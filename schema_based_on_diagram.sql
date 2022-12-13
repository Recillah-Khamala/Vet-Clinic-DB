CREATE TABLE patients (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE
);

CREATE TABLE medical_histories(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(50) NOT NULL
);

CREATE TABLE invocices (
  ID INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total DECIMAL NOT NULL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT NULL REFERENCES medical_histories(id)
);

CREATE TABLE treatments(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type VARCHAR(100) NOT NULL, 
  name VARCHAR(100) NOT NULL
);

CREATE TABLE invoice_items(
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total DECIMAL NOT NULL,
  invoice_id INT NULL REFERENCES invocices(id),
  treatment_id INT NULL REFERENCES treatments(id)
);

CREATE TABLE medical_histories_treatments(
  medical_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id)
);
