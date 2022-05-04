import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class GoogleChartScreen extends StatelessWidget {

  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;

  const GoogleChartScreen(this.seriesList, this.animate, {Key? key}) : super(key: key);

  /// Creates a [BarChart] with sample data and no transition.
  factory GoogleChartScreen.withSampleData() {
    return GoogleChartScreen(
      _createSampleData(),
      // Disable animations for image tests.
      false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: charts.NumericComboChart(seriesList,
            animate: animate,
            // Configure the default renderer as a line renderer. This will be used
            // for any series that does not define a rendererIdKey.
            defaultRenderer: charts.LineRendererConfig(),
            // Custom renderer configuration for the point series.
            customSeriesRenderers: [
              charts.PointRendererConfig(
                // ID used to link series to this renderer.
                  customRendererId: 'customPoint')
            ]),
      ),
    );
  }

  /// Create series list with multiple series
  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final desktopSalesData = [
      LinearSales(0, 5),
      LinearSales(1, 25),
      LinearSales(2, 100),
      LinearSales(3, 75),
    ];

    final tableSalesData = [
      LinearSales(0, 10),
      LinearSales(1, 50),
      LinearSales(2, 200),
      LinearSales(3, 150),
    ];

    final mobileSalesData = [
      LinearSales(0, 10),
      LinearSales(1, 50),
      LinearSales(2, 200),
      LinearSales(3, 150),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      charts.Series<LinearSales, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      charts.Series<LinearSales, int>(
          id: 'Mobile',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: mobileSalesData)
      // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
