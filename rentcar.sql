-- Database: RENTAL MOBIL

-- Drop existing tables (if any) to avoid conflicts
DROP TABLE IF EXISTS Penalty CASCADE;
DROP TABLE IF EXISTS Return CASCADE;
DROP TABLE IF EXISTS Payment CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Employee CASCADE;
DROP TABLE IF EXISTS Car CASCADE;

-- 1. Table: Car
CREATE TABLE Car (
    car_id VARCHAR(10) PRIMARY KEY,
    vehicle_number VARCHAR(20) UNIQUE NOT NULL,
    year_car INT CHECK (year_car BETWEEN 2000 AND 2030),
    name_car VARCHAR(50),
    brand_car VARCHAR(30),
    availability_st VARCHAR(20) CHECK (availability_st IN ('ready', 'not ready'))
);

-- 2. Table: Employee
CREATE TABLE Employee (
    employee_id VARCHAR(10) PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_email VARCHAR(100) UNIQUE,
    position VARCHAR(50)
);

-- 3. Table: Customer
CREATE TABLE Customer (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    address VARCHAR(150),
    phone_number VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- 4. Table: Orders
CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    order_price NUMERIC(12,2) CHECK (order_price > 0),
    order_date DATE NOT NULL,
    return_date DATE NOT NULL,
    duration_rent INT CHECK (duration_rent > 0),
    customer_id VARCHAR(10) REFERENCES Customer(customer_id) ON UPDATE CASCADE ON DELETE SET NULL,
    employee_id VARCHAR(10) REFERENCES Employee(employee_id) ON UPDATE CASCADE ON DELETE SET NULL,
    payment_id VARCHAR(10) UNIQUE,
    return_id VARCHAR(10) UNIQUE,
    car_id VARCHAR(10) REFERENCES Car(car_id) ON UPDATE CASCADE ON DELETE SET NULL
);

-- 5. Table: Payment
CREATE TABLE Payment (
    payment_id VARCHAR(10) PRIMARY KEY,
    payment_price NUMERIC(12,2) CHECK (payment_price >= 0),
    payment_status VARCHAR(20) CHECK (payment_status IN ('paid', 'unpaid')),
    payment_date DATE
);

-- 6. Table: Return
CREATE TABLE Return (
    return_id VARCHAR(10) PRIMARY KEY,
    return_car_date DATE,
    additional_cost NUMERIC(12,2) DEFAULT 0 CHECK (additional_cost >= 0)
);

-- 7. Table: Penalty
CREATE TABLE Penalty (
    penalty_id VARCHAR(10) PRIMARY KEY,
    penalty_price NUMERIC(12,2) CHECK (penalty_price >= 0),
    payment_id VARCHAR(10) REFERENCES Payment(payment_id) ON UPDATE CASCADE ON DELETE SET NULL,
    type_of_violation VARCHAR(100),
    return_id VARCHAR(10) REFERENCES Return(return_id) ON UPDATE CASCADE ON DELETE SET NULL
);


