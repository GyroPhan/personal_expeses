import '../data/data_transation.dart';

class Transation {
  final int idTransation;
  final String titleTransation;
  final DateTime dateTransation;
  final double amountTransation;
  final bool isSpend;
  final String type;
  Transation(
      {this.idTransation,
      this.titleTransation,
      this.amountTransation,
      this.dateTransation,
      this.isSpend,
      this.type});

  Map toJson() => {
        'idTransation': idTransation,
        'titleTransation': titleTransation,
        'dateTransation': dateTransation.toString(),
        'amountTransation': amountTransation,
        'isSpend': isSpend,
        'type': type,
      };
}
