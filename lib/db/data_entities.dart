class DataEntities {
   String tableName = 'products';
   String productId = 'id';
   String product_name = 'product_name';
   String selling_price = 'selling_price';
   String product_barcode = 'product_barcode';
   String cost_price = 'cost_price';
   String unit_of_measurement = 'unit_of_measurement';
   String quantity = 'quantity';
   // String tableName = 'products';


   // Sales Table
   String salesTable = 'sales';
   String saleId = 'saleId';
   String saleDate = 'saleDate';
   String saleTotal = 'totalAmount';

   // SaleDetails Table
   String saleDetailsTable = 'saleDetails';
   String saleDetailId = 'saleDetailId';
   String saleDetailSaleId = 'saleId';
   String saleDetailProductId = 'productId';
   String saleDetailQuantity = 'quantity';
   String saleDetailPrice = 'price';
}