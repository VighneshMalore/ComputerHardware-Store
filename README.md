# ComputerHardware-Store
# 🛒 Computer Store - JSP Based Ecommerce Project

---

## 📋 Project Overview

A full-stack mini ecommerce website built using:

* **Java EE (JSP + Servlets)**
* **MySQL Database**
* **JDBC Connectivity**
* **GlassFish Server** (4.1.1)
* **NetBeans IDE**
* **Simple & Clean Frontend UI**

This project allows customers to register, login, browse products, add products to cart, and manage orders.

---

## 🎯 Features

* User Registration & Login
* Product Catalog Display
* Dynamic Stock Management
* Shopping Cart Management
* Order Processing
* Basic Admin Settings (user deletion, product management)
* Responsive Dark Theme UI with Product Images

---

## 📁 Project Structure

```
Ajava2/
  |
  |-- Web Pages/
  |     |-- cart/
  |     |     |-- cart.jsp
  |     |     |-- processOrder.jsp
  |     |     |-- cart.css
  |     |-- login/
  |     |     |-- login.jsp
  |     |     |-- login.css
  |     |-- order/
  |     |     |-- orderDetails.jsp
  |     |     |-- orderDetails.css
  |     |-- register/
  |     |     |-- register.jsp
  |     |     |-- register.css
  |     |-- setting/
  |     |     |-- add_to_cart.jsp
  |     |-- images/
  |     |     |-- laptop.png, smartphone.png, mouse.png, etc.
  |     |-- index.jsp
  |     |-- dbconn.jsp
  |-- Source Packages/
  |-- Libraries/ (mysql-connector)
  |-- Configuration Files/
```

---

## 🔧 Setup Instructions

### 1️⃣ Prerequisites

* NetBeans (tested on 15+)
* JDK 1.8 or higher
* GlassFish 4.1.1 (pre-installed with NetBeans EE)
* MySQL Server (XAMPP or standalone)

---

### 2️⃣ Database Setup

* Create MySQL database `computerstore`

* Run provided SQL scripts to create tables and insert sample data:

```sql
-- Create database
CREATE DATABASE computerstore;
USE computerstore;

-- Create tables (customers, products, cart, orders, order_items)
-- [Refer to provided SQL file: full_database.sql]

-- Insert sample data:
INSERT INTO customers (first_name, last_name, email, password) VALUES
  ('John', 'Doe', 'john@example.com', 'password123'),
  ('Jane', 'Smith', 'jane@example.com', 'password456');

INSERT INTO products (product_name, price, stock, image_url) VALUES
  ('Laptop', 59999.99, 10, 'laptop.png'),
  ('Smartphone', 29999.50, 15, 'smartphone.png'),
  ('Wireless Mouse', 999.99, 25, 'mouse.png'),
  ('Mechanical Keyboard', 1999.99, 20, 'keyboard.png'),
  ('Bluetooth Headphones', 2999.99, 30, 'headphone.png');
```

---

### 3️⃣ Project Configuration

* Open project in **NetBeans**
* Check `dbconn.jsp` file:

```java
String url = "jdbc:mysql://localhost:3306/computerstore?allowPublicKeyRetrieval=true&useSSL=false";
String username = "root";
String password = "your_mysql_password";
```

* Update MySQL credentials accordingly.
* Right-click project → Clean & Build

---

### 4️⃣ MySQL Connector

* Download `mysql-connector-j-8.x.x.jar`
* Right-click project → Properties → Libraries → Add JAR → Add MySQL Connector.

---

### 5️⃣ Image Setup

* Place product images inside:

```
Web Pages/images/
```

* Ensure file names match database `image_url` column.

---

### 6️⃣ Run the Project

* Start MySQL Server

* Start GlassFish Server via NetBeans

* Deploy Project

* Visit: `http://localhost:8080/Ajava2/index.jsp`

---

## ✨ Screenshots

*Fully working ecommerce product grid with images, cart system, and orders.*

---

## 👌 Credits

* Designed & Developed as a college-level full-stack mini-project.

---

## 💡 Future Improvements

* Admin Dashboard
* Responsive design improvements
* Product search & filtering
* Payment gateway integration
* Session security improvements

---

## 📞 Contact

For any queries or improvements, feel free to connect!
