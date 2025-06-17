import 'dart:io';

List<Map<String, dynamic>> cart = [];

void main() {
  while (true) {
    print('\n===== QUẢN LÝ HÓA ĐƠN BÁN HÀNG =====');
    print('1. Thêm sản phẩm vào giỏ hàng');
    print('2. Sửa sản phẩm trong giỏ hàng');
    print('3. Xóa sản phẩm khỏi giỏ hàng');
    print('4. Hiển thị giỏ hàng');
    print('5. Tính tổng tiền hóa đơn');
    print('6. Thoát chương trình');
    stdout.write('Chọn chức năng (1-6): ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addProduct();
        break;
      case '2':
        editProduct();
        break;
      case '3':
        deleteProduct();
        break;
      case '4':
        displayCart();
        break;
      case '5':
        calculateTotal();
        break;
      case '6':
        print('🔚 Thoát chương trình.');
        return;
      default:
        print('❌ Lựa chọn không hợp lệ!');
    }
  }
}

// === Hàm thêm sản phẩm ===
void addProduct() {
  stdout.write('Nhập tên sản phẩm: ');
  String name = stdin.readLineSync()!;
  int quantity = getIntInput('Nhập số lượng: ');
  double price = getDoubleInput('Nhập giá tiền: ');

  cart.add({'name': name, 'quantity': quantity, 'price': price});
  print('✅ Đã thêm sản phẩm vào giỏ hàng.');
}

// === Hàm sửa sản phẩm ===
void editProduct() {
  if (cart.isEmpty) {
    print('📭 Giỏ hàng trống.');
    return;
  }

  stdout.write('Nhập tên sản phẩm cần sửa: ');
  String name = stdin.readLineSync()!;
  var product = cart.firstWhere(
    (p) => p['name'].toLowerCase() == name.toLowerCase(),
    orElse: () => {},
  );

  if (product.isEmpty) {
    print('❌ Không tìm thấy sản phẩm.');
    return;
  }

  int newQuantity = getIntInput('Nhập số lượng mới: ');
  double newPrice = getDoubleInput('Nhập giá tiền mới: ');
  product['quantity'] = newQuantity;
  product['price'] = newPrice;

  print('✅ Đã cập nhật sản phẩm.');
}

// === Hàm xóa sản phẩm ===
void deleteProduct() {
  if (cart.isEmpty) {
    print('📭 Giỏ hàng trống.');
    return;
  }

  stdout.write('Nhập tên sản phẩm cần xóa: ');
  String name = stdin.readLineSync()!;
  int index = cart.indexWhere((p) => p['name'].toLowerCase() == name.toLowerCase());

  if (index == -1) {
    print('❌ Không tìm thấy sản phẩm.');
    return;
  }

  cart.removeAt(index);
  print('🗑️ Đã xóa sản phẩm khỏi giỏ hàng.');
}

// === Hàm hiển thị giỏ hàng ===
void displayCart() {
  if (cart.isEmpty) {
    print('📭 Giỏ hàng trống.');
    return;
  }

  print('\n===== DANH SÁCH GIỎ HÀNG =====');
  for (var i = 0; i < cart.length; i++) {
    var item = cart[i];
    print('${i + 1}. ${item['name']} - SL: ${item['quantity']} - Giá: ${item['price'].toStringAsFixed(2)}');
  }
}

// === Hàm tính tổng tiền ===
void calculateTotal() {
  if (cart.isEmpty) {
    print('📭 Giỏ hàng trống.');
    return;
  }

  double total = 0;
  for (var item in cart) {
    total += item['quantity'] * item['price'];
  }

  print('💵 Tổng tiền hóa đơn: ${total.toStringAsFixed(2)} VND');
}

// === Hàm nhập số nguyên an toàn ===
int getIntInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    int? value = int.tryParse(input!);
    if (value != null && value >= 0) {
      return value;
    }
    print('❌ Vui lòng nhập số nguyên hợp lệ!');
  }
}

// === Hàm nhập số thực an toàn ===
double getDoubleInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    double? value = double.tryParse(input!);
    if (value != null && value >= 0) {
      return value;
    }
    print('❌ Vui lòng nhập số hợp lệ!');
  }
}
