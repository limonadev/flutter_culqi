enum Months {
	January,
	February,
	March,
	April,
	May,
	June,
	July,
	August,
	September,
	October,
	November,
	December
}

class Translations{

	static List<String> _supportedLocales = ['en', 'es'];
	static const String defaultLocale = 'es';


	static Map<Months, String> _enMonthNames = {
		Months.January : 'January',
		Months.February : 'February',
		Months.March : 'March',
		Months.April : 'April',
		Months.May : 'May',
		Months.June : 'June',
		Months.July : 'July',
		Months.August : 'August',
		Months.September : 'September',
		Months.October : 'October',
		Months.November : 'November',
		Months.December : 'December'
	};
	static Map<Months, String> _esMonthNames = {
		Months.January : 'Enero',
		Months.February : 'Febrero',
		Months.March : 'Marzo',
		Months.April : 'Abril',
		Months.May : 'Mayo',
		Months.June : 'Junio',
		Months.July : 'Julio',
		Months.August : 'Agosto',
		Months.September : 'Setiembre',
		Months.October : 'Octubre',
		Months.November : 'Noviembre',
		Months.December : 'Diciembre'
	};


	static Map<dynamic, String> _englishCommon = {
		'emptyWarningLabel' : 'This field cannot be empty',
		'cardNumberLabel' : 'Card Number',
		'expirationYearLabel' : 'Expiration Year',
		'expirationMonthLabel' : 'Expiration Month',
		'cvvLabel' : 'CVV'
	};

	static Map<dynamic, String> _spanishCommon = {
		'emptyWarningLabel' : 'This field cannot be empty',
		'cardNumberLabel' : 'Número de Tarjeta',
		'expirationYearLabel' : 'Año de Expiración',
		'expirationMonthLabel' : 'Mes de Expiración',
		'cvvLabel' : 'CVV'
	};

	static Map<String, Map<dynamic, String>> _translate = {
		'en' : _englishCommon
		..addAll(_enMonthNames),
		'es' : _spanishCommon
		..addAll(_esMonthNames)
	};

	static String cardNumberLabel(String locale){
		if(!_supportedLocales.contains(locale)) locale = defaultLocale;

		return _translate[locale]['cardNumberLabel'];
	}

	static String emptyWarningLabel(String locale){
		if(!_supportedLocales.contains(locale)) locale = defaultLocale;

		return _translate[locale]['emptyWarningLabel'];
	}

	static String expirationYearLabel(String locale){
		if(!_supportedLocales.contains(locale)) locale = defaultLocale;

		return _translate[locale]['expirationYearLabel'];
	}

	static String expirationMonthLabel(String locale){
		if(!_supportedLocales.contains(locale)) locale = defaultLocale;

		return _translate[locale]['expirationMonthLabel'];
	}

	static String cvvLabel(String locale){
		if(!_supportedLocales.contains(locale)) locale = defaultLocale;

		return _translate[locale]['cvvLabel'];
	}

	static List<String> months(String locale){
		if(!_supportedLocales.contains(locale)) locale = defaultLocale;

		List<String> _months = [];
		for(var m in Months.values){
			_months.add(_translate[locale][m]);
		}

		return _months;
	}

}