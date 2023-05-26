-- APAGA O BANCO DE DADOS UVV SE JA EXISTIR NO SISTEMA

DROP database IF EXISTS uvv;

-- APAGA O USUÁRIO MURILO SE JA EXISTIR NO SISTEMA

DROP USER IF EXISTS murilo;

-- CRIA O USUÁRIO MURILO E DEFINE UMA SENHA

CREATE USER murilo WITH createdb inherit login password '0810';

-- CRIA O BANCO DE DADOS UVV

CREATE database uvv
	   OWNER murilo
	   TEMPLATE template0
	   ENCODING 'UTF8'
	   LC_COLLATE 'pt_BR.UTF-8'
	   LC_CTYPE 'pt_BR.UTF-8'
	   ALLOW_CONNECTIONS TRUE;
	  
-- CONECTA O USUÁRIO MURILO E O BANCO DE DADOS UVV
	  
   \c 'dbname=uvv user= murilo password=0810';
  
--CRIA O SCHEMA LOJAS COM AUTORIZAÇÃO DO USUÁRIO
  
  CREATE SCHEMA lojas AUTHORIZATION murilo;
ALTER USER murilo
SET search_path TO lojas, "$user", public;

--CRIA A TABELA

CREATE TABLE produtos (
             produto_id 			  NUMERIC(38) NOT NULL,
             nome 					  VARCHAR(255) NOT NULL,
             preco_unitario 		  NUMERIC(10,2),
             detalhes BYTEA,
             imagem BYTEA,
             imagem_mime_type 		  VARCHAR(512),
             imagem_arquivo 		  VARCHAR(512),
             imagem_charset 		  VARCHAR(512),
             imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);

--COMENTÁRIO DE CADA COLUNA

COMMENT ON COLUMN produtos.produto_id IS 'essa coluna mostra o id cadastrado de cada produto';
COMMENT ON COLUMN produtos.nome IS 'essa coluna mostra o nome de cada produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'essa coluna mostra o preço unitario de cada produto';
COMMENT ON COLUMN produtos.detalhes IS 'essa coluna mostra os detalhes de cada produto';
COMMENT ON COLUMN produtos.imagem IS 'essa coluna mostra a imagem do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'essa coluna mostra a ultima atualização da imagem dos produtos';

--CRIA A TABELA

CREATE TABLE lojas (
             loja_id 				 NUMERIC(38) NOT NULL,
             nome 					 VARCHAR(255) NOT NULL,
             endereco_web 			 VARCHAR(100),
             endereco_fisico 		 VARCHAR(512),
             latitude 				 NUMERIC,
             longitude 				 NUMERIC,
             logo BYTEA,
             logo_mime_type 		 VARCHAR(512),
             logo_arquivo 			 VARCHAR(512),
             logo_charset 			 VARCHAR(512),
             logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);

--COMENTÁRIO DE CADA COLUNA

COMMENT ON COLUMN lojas.loja_id IS 'essa coluna mostra o id cadastrado de cada loja';
COMMENT ON COLUMN lojas.nome IS 'essa coluna mostra o nome das lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'essa coluna mostra o endereço do site na internet';
COMMENT ON COLUMN lojas.endereco_fisico IS 'essa coluna mostra o endereço fisico da loja';
COMMENT ON COLUMN lojas.latitude IS 'essa coluna mostra latitude da loja';
COMMENT ON COLUMN lojas.longitude IS 'essa coluna mostra a longitude da loja';
COMMENT ON COLUMN lojas.logo IS 'essa coluna mostra a logo das lojas';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'essa coluna mostra a data da ultima atualização da logo da loja';

--CRIA A TABELA

CREATE TABLE estoques (
             estoque_id NUMERIC(38) NOT NULL,
             loja_id    NUMERIC(38) NOT NULL,
             produto_id NUMERIC(38) NOT NULL,
             quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);

--COMENTÁRIO DE CADA COLUNA

COMMENT ON COLUMN estoques.estoque_id IS 'essa coluna mostra o id cadastrado de cada estoque';
COMMENT ON COLUMN estoques.loja_id IS 'essa coluna mostra id cadastrado de cada loja';
COMMENT ON COLUMN estoques.produto_id IS 'essa coluna mostra o id cadastrado de cada produto';
COMMENT ON COLUMN estoques.quantidade IS 'essa coluna mostra a quantidade de produtos no estoque';

--CRIA A TABELA

CREATE TABLE clientes (
             cliente_id NUMERIC(38) NOT NULL,
             email 	    VARCHAR(255) NOT NULL,
             nome 	    VARCHAR(255) NOT NULL,
             telefone1  VARCHAR(20),
             telefone2  VARCHAR(20),
             telefone3  VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);

--COMENTÁRIO DE CADA COLUNA

COMMENT ON COLUMN clientes.email IS 'essa coluna mostra o email dos clientes';
COMMENT ON COLUMN clientes.nome IS 'essa coluna mostra o nome dos clientes';
COMMENT ON COLUMN clientes.telefone1 IS 'essa coluna mostra os telefones dos clientes';
COMMENT ON COLUMN clientes.telefone2 IS 'essa coluna mostra os telefones dos clientes';
COMMENT ON COLUMN clientes.telefone3 IS 'essa coluna mostra os telefones dos clientes';

--CRIA A TABELA

CREATE TABLE envios (
             envio_id 		  NUMERIC(38) NOT NULL,
             loja_id 		  NUMERIC(38) NOT NULL,
             cliente_id 	  NUMERIC(38) NOT NULL,
             endereco_entrega VARCHAR(512) NOT NULL,
             status 		  VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);

--COMENTÁRIO DE CADA COLUNA

COMMENT ON COLUMN envios.envio_id IS 'essa coluna mostra o id cadastrado de cada envio';
COMMENT ON COLUMN envios.loja_id IS 'essa coluna mostra o id cadastrado de cada loja';
COMMENT ON COLUMN envios.cliente_id IS 'essa coluna mostra o id cadastrado de cada cliente';
COMMENT ON COLUMN envios.endereco_entrega IS 'essa coluna mostra o endereço em que a entrega sera feita';
COMMENT ON COLUMN envios.status IS 'essa coluna mostra o status do envio';

--CRIA A TABELA

CREATE TABLE pedidos (
             pedido_id  NUMERIC(38) NOT NULL,
             cliente_id NUMERIC(38) NOT NULL,
             data_hora  TIMESTAMP NOT NULL,
             status 	VARCHAR(15) NOT NULL,
             loja_id    NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);

--COMENTÁRIO DE CADA COLUNA

COMMENT ON COLUMN pedidos.pedido_id IS 'essa coluna mostra o id cadastrado de cada pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'essa coluna mostra o id cadastrado de cada cliente';
COMMENT ON COLUMN pedidos.data_hora IS 'essa coluna mostra a data e a hora dos pedidos';
COMMENT ON COLUMN pedidos.status IS 'essa coluna mostra o status dos pedidos';
COMMENT ON COLUMN pedidos.loja_id IS 'essa coluna mostra o id cadastrado de cada loja';

--CRIA A TABELA

CREATE TABLE pedidos_itens (
			 pedido_id 			NUMERIC(38) NOT NULL,
             produto_id 		NUMERIC(38) NOT NULL,
             numero_da_linha 	NUMERIC(38) NOT NULL,
             preco_unitario  	NUMERIC(10,2) NOT NULL,
             quantidade 		NUMERIC(38) NOT NULL,
             envio_id 			NUMERIC(38),
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

--COMENTÁRIO DE CADA COLUNA

COMMENT ON COLUMN pedidos_itens.pedido_id IS 'essa coluna mostra o id cadastrado de cada pedido';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'essa coluna mostra o id cadastrado de cada produto';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'essa coluna mostra o numero da linha dos itens pedidos';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'essa coluna mostra o preço unitario dos produtos';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'essa coluna mostra a quantidade de itens por pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'essa coluna mostra o id cadastrado de cada envio';

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--ADICIONA RESTRIÇÕES NAS TABELAS

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--DEIXA RESTRITO A QUANTIDADE NO ESTOQUE NÃO PODE SER NEGATIVA

ALTER TABLE estoques
ADD CONSTRAINT quantidade_negativa_es CHECK (quantidade >= 0);
	
--DEIXA RESTRITO A QUANTIDADE DE ITENS PEDIDOS NÃO PODE SER NAGTIVO
	
ALTER TABLE pedidos_itens
ADD CONSTRAINT quantidade_negativa_pi CHECK (quantidade >= 0);
	
--DEIXA RESTRITO OS POSSIVEIS STATUS DO PEDIDO
	
ALTER TABLE pedidos
ADD CONSTRAINT status_pedido CHECK (status IN ( 'CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO' ));
	
--DEIXA RESTRITO OS POSSIVEIS STATUS DO ENVIO
	
ALTER TABLE envios
ADD CONSTRAINT status_envio CHECK (status IN ( 'CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE' ));
	
--DEIXA RESTRITO O PREÇO DO PRODUTO NÃO PODE SER NEGATIVO
	
ALTER TABLE produtos
ADD CONSTRAINT preco_negativo_pd CHECK ( preco_unitario >= 0 );
	
--DEIXA RESTRITO QUE O PREÇO DO PEDIDO NÃO PODE SER NEGATIVO
	
ALTER TABLE pedidos_itens
ADD CONSTRAINT preco_negativo_pi CHECK ( preco_unitario >= 0 );
	
--DEIXA RESTRITO QUE PELO MENOS UM DOS ENDEREÇOS DA LOJA NÃO SEJA NULO
	
ALTER TABLE lojas
ADD CONSTRAINT endereco_web_fis CHECK (( endereco_web IS NOT NULL ) OR ( endereco_fisico IS NOT NULL ));

