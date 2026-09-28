<?php
require_once __DIR__ . '/config/functions.php';
$busca = trim($_GET['q'] ?? '');
$resposta = $busca !== '' ? buscarConteudo($pdo, $busca) : null;
$categorias = $pdo->query("SELECT id, nome FROM categorias ORDER BY nome")->fetchAll();
$categoriaId = (int)($_GET['categoria'] ?? 0);
$listaCategoria = [];
if ($categoriaId > 0) {
    $st = $pdo->prepare("SELECT c.*, cat.nome AS categoria_nome FROM conteudos c JOIN categorias cat ON cat.id=c.categoria_id WHERE c.ativo=1 AND c.categoria_id=? ORDER BY c.titulo");
    $st->execute([$categoriaId]);
    $listaCategoria = $st->fetchAll();
}
?>
<!doctype html>
<html lang="pt-BR">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>IFC Assist</title><link rel="stylesheet" href="assets/style.css">
</head>
<body>
<header class="topo"><div class="marca"><div class="logo">IFC</div><div><strong>IFC Assist</strong><span>Assistente Virtual Acadêmico</span></div></div><a class="admin-link" href="admin/login.php">Área administrativa</a></header>
<main class="container">
<section class="hero"><p class="eyebrow">IFC Fraiburgo</p><h1>Olá! Como posso ajudar?</h1><p>Digite uma dúvida ou algumas palavras-chave sobre o campus.</p>
<form class="busca" method="get"><input name="q" value="<?=e($busca)?>" placeholder="Ex.: onde fica minha sala?" autocomplete="off"><button>Pesquisar</button></form>
<div class="sugestoes"><a href="?q=onde fica minha sala">Salas</a><a href="?q=horário do ônibus">Transporte</a><a href="?q=eventos">Eventos</a><a href="?q=como acessar o SIGAA">SIGAA</a></div></section>
<?php if ($busca !== ''): ?>
<section class="resultado"><h2>Resultado</h2><?php if ($resposta): ?><div class="card"><span class="tag"><?=e($resposta['categoria_nome'])?></span><h3><?=e($resposta['titulo'])?></h3><p><?=nl2br(e($resposta['resposta']))?></p></div><?php else: ?><div class="card vazio"><h3>Não encontramos uma resposta.</h3><p>Tente usar outras palavras ou escolha uma categoria abaixo. O IFC Assist não inventa respostas.</p></div><?php endif; ?></section>
<?php endif; ?>
<section class="categorias"><h2>Encontre por categoria</h2><div class="grid"><?php foreach ($categorias as $cat): ?><a class="categoria" href="?categoria=<?=$cat['id']?>"><span><?=e($cat['nome'])?></span><b>›</b></a><?php endforeach; ?></div></section>
<?php if ($categoriaId > 0): ?><section class="resultado"><h2><?=e($listaCategoria[0]['categoria_nome'] ?? 'Categoria')?></h2><?php if ($listaCategoria): foreach ($listaCategoria as $item): ?><div class="card"><h3><?=e($item['titulo'])?></h3><p><?=nl2br(e($item['resposta']))?></p></div><?php endforeach; else: ?><div class="card vazio"><p>Nenhum conteúdo ativo nessa categoria.</p></div><?php endif; ?></section><?php endif; ?>
</main><footer>IFC Assist • Base de informações cadastradas e atualizáveis</footer>
</body></html>
