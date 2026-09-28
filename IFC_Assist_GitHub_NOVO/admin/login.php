<?php
require_once __DIR__ . '/../config/functions.php';
if (session_status() !== PHP_SESSION_ACTIVE) session_start();
if (!empty($_SESSION['admin_id'])) { header('Location: index.php'); exit; }
$erro = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? ''); $senha = $_POST['senha'] ?? '';
    $st = $pdo->prepare('SELECT * FROM administradores WHERE email=? LIMIT 1'); $st->execute([$email]); $admin=$st->fetch();
    if ($admin && password_verify($senha, $admin['senha'])) { session_regenerate_id(true); $_SESSION['admin_id']=$admin['id']; $_SESSION['admin_nome']=$admin['nome']; $_SESSION['ultima_atividade']=time(); header('Location: index.php'); exit; }
    $erro='E-mail ou senha inválidos.';
}
?><!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Login - IFC Assist</title><link rel="stylesheet" href="../assets/style.css"></head><body><main class="login-wrap"><div class="login-card"><div class="logo grande">IFC</div><h1>Área administrativa</h1><p>Entre para administrar a base de informações.</p><?php if ($erro): ?><div class="erro"><?=e($erro)?></div><?php endif; ?><form method="post"><label>E-mail<input type="email" name="email" required></label><label>Senha<input type="password" name="senha" required></label><button class="full">Entrar</button></form><a href="../index.php" class="voltar">← Voltar ao assistente</a></div></main></body></html>
