

CREATE TABLE doctor (
    doctor_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL
);

CREATE TABLE patient (
    patient_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,

    gender VARCHAR(10) NOT NULL 
        CHECK (gender IN ('Male', 'Female', 'Other')),

    email VARCHAR(150) UNIQUE,

    date_of_birth DATE NOT NULL,

    doctor_id INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE device (
    device_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    device_name VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100)
);

CREATE TABLE measurement (
    measurement_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    patient_id INT NOT NULL,
    device_id INT NOT NULL,

    measurement_date DATE NOT NULL 
        CHECK (measurement_date > DATE '2026-01-01'),

    value DECIMAL(10,2) NOT NULL 
        CHECK (value >= 0),

    height DECIMAL(5,2),
    weight DECIMAL(5,2),

    bmi DECIMAL(5,2) GENERATED ALWAYS AS (
        CASE 
            WHEN height IS NOT NULL AND weight IS NOT NULL 
            THEN weight / (height * height)
            ELSE NULL
        END
    ) STORED,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (device_id) REFERENCES device(device_id)
);
