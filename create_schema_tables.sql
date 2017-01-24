-- Create the master table for indices

CREATE TABLE `global_indices_symbols` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
 `google_code` varchar(32) DEFAULT NULL,
  `google_id` bigint(20) DEFAULT NULL,
  `indice_name` varchar(32) DEFAULT NULL,
  `indice_desc` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gis_unique_keys` (`indice_name`,`google_id`,`indice_desc`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- Create the table which will store the indices daily data

CREATE TABLE `global_indices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `indices_name` varchar(64) DEFAULT NULL,
  `price_date` date DEFAULT NULL,
  `open_price` decimal(20,2) DEFAULT NULL,
  `high_price` decimal(20,2) DEFAULT NULL,
  `low_price` decimal(20,2) DEFAULT NULL,
  `close_price` decimal(20,2) DEFAULT NULL,
  `volume` decimal(20,2) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `indices_data_uk` (`indices_name`,`price_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='	';


-- Insert google finance details for the indices

INSERT INTO global_indices_symbols VALUES(NULL,'SHA:000001',7521596,'SSE_COMPOSIT','SSE Composite Index');         
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXNIKKEI:NI225',15513676,'Nikkei225','Nikkei 225'); 
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXHANGSENG:HSI',13414271,'HANGSENGINDEX','HANG SENG INDEX');
INSERT INTO global_indices_symbols VALUES(NULL,'TPE:TAIEX',9947405,'TSECweightedindex','TSEC weighted index');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXFTSE:UKX',12590587,'FTSE100','FTSE 100');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXSTOXX:SX5E',7354851,'ESTX50PREUR','ESTX 50 PR.EUR');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXEURO:PX1',9237947,'CAC40','CAC 40');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXTSI:OSPTX',9291235,'SnPTSXCompositeindex','S&P/TSX Composite index');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXASX:XJO',14240693,'SnPASX200','S&P/ASX 200');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXBOM:SENSEX',15173681,'SnPBSESENSEX','S&P BSE SENSEX');
INSERT INTO global_indices_symbols VALUES(NULL,'TLV:T25',835285966959493,'TA25','TA-25');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXSWX:SMI',1052581216806242,'SMIPR','SMI PR');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXVIE:ATX',1066235873319497,'AustrianTradedIndexinEUR','Austrian Traded Index in EUR');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXBVMF:IBOV',851377182412228,'IBOVESPA','IBOVESPA');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXBKK:SET',192906426752897,'SETIndex','SET Index');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXIST:XU100',456528970194751,'BIST100','BIST 100');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXBME:IB',1054681020857808,'IBEX35','IBEX 35');
INSERT INTO global_indices_symbols VALUES(NULL,'WSE:WIG',698684623076010,'WIG','WIG');
INSERT INTO global_indices_symbols VALUES(NULL,'TADAWUL:TASI',1095233500396574,'TadawulAllSharesIndex','Tadawul All Shares Index');
INSERT INTO global_indices_symbols VALUES(NULL,'BCBA:IAR',393322345722481,'MERVALARGENTINA','MERVAL ARGENTINA');
INSERT INTO global_indices_symbols VALUES(NULL,'INDEXBMV:ME',999678732197294,'IPCMEXICO','IPC MEXICO');
INSERT INTO global_indices_symbols VALUES(NULL,'IDX:COMPOSITE',218574097879841,'CompositeIndex','Composite Index');