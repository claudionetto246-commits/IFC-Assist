<?php
require_once __DIR__ . '/../config/functions.php'; exigirLogin();
$id=(int)($_GET['id']??0); if($id>0){$st=$pdo->prepare('DELETE FROM conteudos WHERE id=?');$st->execute([$id]);} header('Location: index.php?ok=1'); exit;
