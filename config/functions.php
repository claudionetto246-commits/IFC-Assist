<?php
require_once __DIR__ . '/database.php';

function e($value): string {
    return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8');
}

function normalizar(string $texto): string {
    $texto = mb_strtolower($texto, 'UTF-8');
    $texto = strtr($texto, [
        'á'=>'a','à'=>'a','ã'=>'a','â'=>'a','ä'=>'a',
        'é'=>'e','è'=>'e','ê'=>'e','ë'=>'e',
        'í'=>'i','ì'=>'i','î'=>'i','ï'=>'i',
        'ó'=>'o','ò'=>'o','õ'=>'o','ô'=>'o','ö'=>'o',
        'ú'=>'u','ù'=>'u','û'=>'u','ü'=>'u',
        'ç'=>'c'
    ]);
    return $texto;
}

function palavras(string $texto): array {
    $texto = normalizar($texto);
    $texto = preg_replace('/[^a-z0-9\s]/u', ' ', $texto);
    $lista = preg_split('/\s+/', trim($texto), -1, PREG_SPLIT_NO_EMPTY);
    $ignorar = ['onde','como','qual','quais','para','sobre','uma','uns','das','dos','que','com','por','tem','tenho','meu','minha','isso','esse','essa'];
    $saida = [];
    foreach ($lista as $p) {
        if (strlen($p) >= 3 && !in_array($p, $ignorar, true)) $saida[$p] = true;
    }
    return array_keys($saida);
}

function buscarConteudo(PDO $pdo, string $pergunta): ?array {
    $termos = palavras($pergunta);
    if (!$termos) return null;

    $stmt = $pdo->query("SELECT c.*, cat.nome AS categoria_nome FROM conteudos c JOIN categorias cat ON cat.id = c.categoria_id WHERE c.ativo = 1");
    $conteudos = $stmt->fetchAll();
    $melhor = null;
    $melhorScore = 0;

    foreach ($conteudos as $item) {
        $base = normalizar($item['titulo'] . ' ' . $item['palavras_chave']);
        $basePalavras = palavras($base);
        if (!$basePalavras) continue;
        $acertos = 0;
        foreach ($termos as $termo) {
            foreach ($basePalavras as $bp) {
                if ($termo === $bp || (strlen($termo) >= 4 && (str_contains($bp, $termo) || str_contains($termo, $bp)))) {
                    $acertos++;
                    break;
                }
            }
        }
        $score = $acertos / count($termos);
        if ($score > $melhorScore) {
            $melhorScore = $score;
            $melhor = $item;
            $melhor['score'] = $score;
        }
    }
    return ($melhor && $melhorScore >= 0.5) ? $melhor : null;
}

function exigirLogin(): void {
    if (session_status() !== PHP_SESSION_ACTIVE) session_start();
    if (empty($_SESSION['admin_id'])) {
        header('Location: login.php');
        exit;
    }
    if (!empty($_SESSION['ultima_atividade']) && time() - $_SESSION['ultima_atividade'] > 1800) {
        session_destroy();
        header('Location: login.php?expirada=1');
        exit;
    }
    $_SESSION['ultima_atividade'] = time();
}
