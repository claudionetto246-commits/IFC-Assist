# IFC Assist

Sistema web para responder dúvidas de discentes a partir de uma base de conhecimento pré-cadastrada. A busca utiliza palavras-chave e normalização de texto para localizar a resposta mais compatível.

## Tecnologias

- PHP 8
- MySQL
- HTML5, CSS3 e JavaScript
- Git e GitHub
- Hospedagem testada: InfinityFree

## Estrutura

```text
IFC_Assist_InfinityFree/
├── admin/                  # Login e administração da base
├── assets/                 # CSS
├── config/                 # Conexão e funções
├── database/               # SQL da versão final
└── index.php               # Assistente
```

## Banco de dados

A versão final validada possui 3 tabelas principais:

- `administradores`
- `categorias`
- `conteudos`

O SQL final contém 9 categorias e 29 conteúdos de exemplo/base para o IFC Assist.

### Importação

Use `database/IFC_Assist_InfinityFree_FINAL.sql` em um banco vazio. Se o banco já tiver as tabelas, faça backup antes de substituir os dados. O arquivo `database/IFC_Assist_InfinityFree_SUBSTITUIR_BANCO.sql` é destrutivo e deve ser usado somente após backup.

## Configuração

1. Copie `config/database.example.php` para `config/database.php`.
2. Preencha host, banco, usuário e senha do MySQL.
3. O arquivo `config/database.php` é local e fica fora do Git por segurança.

Nunca versione credenciais reais do banco.

## Acesso administrativo

O login administrativo usa `password_verify()` e senhas bcrypt. Para produção, defina uma senha forte e exclusiva para o administrador. Não use a senha de teste em ambiente público.

## Testes realizados

A estrutura foi validada no InfinityFree após a importação da versão final: 3 tabelas, 1 administrador, 9 categorias e 29 conteúdos.

## Deploy no InfinityFree

Envie o conteúdo do projeto para a pasta pública do site, mantendo `index.php` na raiz. Configure a conexão MySQL no arquivo local de configuração.
