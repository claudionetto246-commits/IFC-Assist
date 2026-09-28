<?php
// Copie este arquivo para config/database.php e preencha os dados
// fornecidos pelo seu provedor de hospedagem.

const DB_HOST = 'SEU_HOST_MYSQL';
const DB_NAME = 'SEU_BANCO';
const DB_USER = 'SEU_USUARIO';
const DB_PASS = 'SUA_SENHA_MYSQL';

try {
    $pdo = new PDO(
        'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8mb4',
        DB_USER,
        DB_PASS,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );
} catch (PDOException $e) {
    http_response_code(500);
    exit('Não foi possível conectar ao banco de dados. Confira config/database.php.');
}
