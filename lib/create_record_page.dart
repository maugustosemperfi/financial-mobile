import 'package:financial/application.dart';
import 'package:financial/enum/enum_record_type.dart';
import 'package:financial/model/account.dart';
import 'package:financial/model/category.dart';
import 'package:financial/model/credit_card.dart';
import 'package:financial/model/record.dart';
import 'package:financial/services/accounts_data.dart';
import 'package:financial/services/credit_card_data.dart';
import 'package:financial/services/records_service.dart';
import 'package:financial/styling.dart';
import 'package:financial/widgets/dixty_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateRecordPage extends StatefulWidget {
  final double balance;
  final EnumRecordType recordType;

  const CreateRecordPage({this.balance, this.recordType});

  @override
  _CreateRecordPageState createState() => _CreateRecordPageState();
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  final createRecordForm = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  Account _simpleAccountSelected;
  CreditCard _simpleCreditCard;
  Category _selectedCategory;

  MoneyMaskedTextController _controller = MoneyMaskedTextController(
    leftSymbol: '',
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 000,
  );

  TextEditingController _dateController = TextEditingController();
  TextEditingController _simpleAccountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.updateValue(widget.balance);
    _setDate(DateTime.now());
    _setAccountSelected(AccountsData.simpleAccounts[0]);
  }

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        _setDate(picked);
      });
  }

  _setAccountSelected(Account simpleAccount) {
    setState(() {
      _simpleAccountSelected = simpleAccount;
      if (simpleAccount != null) {
        _simpleAccountController.text = "${simpleAccount.name}";
      }
    });
  }

  _setCreditCardSelected(CreditCard creditCard) {
    setState(() {
      _simpleCreditCard = creditCard;
      if (creditCard != null) {
        _simpleAccountController.text = "${creditCard.name}";
      }
    });
  }

  void _setDate(DateTime picked) {
    selectedDate = picked;
    _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
  }

  _createRecord() async {
    Record record = new Record();
    record.description = this._descriptionController.text;
    record.account = this._simpleAccountSelected;
    record.value = this.widget.balance;
    record.recordDate = this.selectedDate;
    record.type = widget.recordType;
    record.creditCard = this._simpleCreditCard;
    record.category = this._selectedCategory;

    await RecordsService.createRecord(record);

    Application.router.pop(context);
    Application.router.pop(context);
  }

  _navigateToAddPage() {
    Application.router.pop(context);
  }

  Future _selectAccount() async {
    final paymentSelected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return selectAccountDialog;
        });
    if (paymentSelected != null) {
      if (paymentSelected is CreditCard) {
        _setCreditCardSelected(paymentSelected);
        _setAccountSelected(null);
      } else {
        _setCreditCardSelected(null);
        _setAccountSelected(paymentSelected);
      }
    }
  }

  Future _selectCategory() async {
    final Category category = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return selectCategoryDialog;
        });

    if (category != null) {
      _setSelectedCategory(category);
    }
  }

  _setSelectedCategory(Category category) {
    setState(() {
      _categoryController.text = category.description;
      _selectedCategory = category;
    });
  }

  _initDefaultCategory() {
    // _setSelectedCategory(_authenticationBloc.state.props[1]);
  }

  @override
  Widget build(BuildContext context) {
    // _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _initDefaultCategory();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: widget.recordType == EnumRecordType.income
              ? AppTheme.primary
              : AppTheme.warn,
        ),
      ),
      body: Material(
        child: SafeArea(
          child: Container(
            color: AppTheme.nearlyWhite,
            padding: EdgeInsets.only(bottom: 36),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                _moneyIndicator,
                _formRecord,
                Expanded(
                  child: Container(),
                ),
                _fab,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _moneyIndicator {
    return GestureDetector(
      onTap: () {
        _navigateToAddPage();
      },
      child: Container(
        padding: EdgeInsets.only(top: 60, bottom: 30),
        color: widget.recordType == EnumRecordType.income
            ? AppTheme.primary
            : AppTheme.warn,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(color: AppTheme.nearlyWhite, fontSize: 50),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _formRecord {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: createRecordForm,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: DixtyTextFormFieldWiget(
                    decorationIcon: Icon(
                      Icons.calendar_today,
                      color: AppTheme.grey,
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                    readOnly: true,
                    controller: _dateController,
                  ),
                ),
              ],
            ),
            DixtyTextFormFieldWiget(
              decorationIcon: Icon(
                Icons.description,
                color: AppTheme.grey,
              ),
              hintText: "Description",
              controller: _descriptionController,
            ),
            InkWell(
              onTap: () {
                _selectAccount();
              },
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.network(
                          _simpleAccountSelected != null
                              ? _simpleAccountSelected.bank.iconUrl
                              : _simpleCreditCard.bank.iconUrl,
                          height: 24,
                        ),
                        padding: EdgeInsets.only(right: 16),
                      )
                    ],
                  ),
                  Expanded(
                    child: DixtyTextFormFieldWiget(
                      controller: _simpleAccountController,
                      enabled: false,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _selectCategory();
              },
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _selectedCategory != null
                          ? Container(
                              padding: EdgeInsets.only(right: 16),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Color(
                                    int.parse(_selectedCategory.iconColor)),
                                child: Icon(
                                  MdiIcons.fromString(
                                      _selectedCategory.iconName),
                                  size: 12,
                                  color: AppTheme.nearlyWhite,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Expanded(
                    child: DixtyTextFormFieldWiget(
                      controller: _categoryController,
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _fab {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FloatingActionButton(
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
          backgroundColor: widget.recordType == EnumRecordType.income
              ? AppTheme.primary
              : AppTheme.warn,
          onPressed: () {
            _createRecord();
          },
        )
      ],
    );
  }

  SimpleDialog get selectCategoryDialog {
    List<Category> categories = [];

    return SimpleDialog(
      title: Text(
        "Categorias",
        style: AppTheme.headlineLight,
      ),
      children: ListTile.divideTiles(
          context: context,
          tiles: categories.map((category) {
            return ListTile(
              title: Text(category.description),
              onTap: () {
                Navigator.pop(context, category);
              },
              leading: CircleAvatar(
                child: Icon(
                  MdiIcons.fromString(category.iconName),
                  color: AppTheme.nearlyWhite,
                ),
                backgroundColor: Color(int.parse(category.iconColor)),
              ),
            );
          })).toList(),
    );
  }

  SimpleDialog get selectAccountDialog {
    return SimpleDialog(
      title: Text(
        "Select account",
        style: AppTheme.headlineLight,
      ),
      children: <Widget>[
        ListTile(
          title: Text("Accounts"),
        ),
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: ListTile.divideTiles(
              context: context,
              tiles: AccountsData.simpleAccounts.map((simpleAccount) {
                return ListTile(
                  title: Text(simpleAccount.name),
                  leading: simpleAccount != null
                      ? Image.network(
                          simpleAccount.bank.iconUrl,
                          height: 36,
                        )
                      : Container(),
                  onTap: () {
                    Navigator.pop(context, simpleAccount);
                  },
                );
              })).toList(),
        ),
        ListTile(
          title: Text("Credit Cards"),
        ),
        Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: ListTile.divideTiles(
              context: context,
              tiles: CreditCardData.simpleCreditCards.map((creditCard) {
                return ListTile(
                  title: Text(creditCard.name),
                  leading: creditCard != null
                      ? Image.network(
                          creditCard.bank.iconUrl,
                          height: 36,
                        )
                      : Container(),
                  onTap: () {
                    Navigator.pop(context, creditCard);
                  },
                );
              })).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              textColor: AppTheme.primary,
              child: Text("CANCEL"),
            )
          ],
        )
      ],
    );
  }
}
