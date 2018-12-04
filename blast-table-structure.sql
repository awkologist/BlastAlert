DROP TABLE IF EXISTS `blast`;
CREATE TABLE `blast` (
  `query` varchar(20) DEFAULT NULL,
  `subject` varchar(20) DEFAULT NULL,
  `identity` float DEFAULT NULL,
  `alignment` int(11) DEFAULT NULL,
  `mismatches` int(11) DEFAULT NULL,
  `gaps` int(11) DEFAULT NULL,
  `q_start` int(11) DEFAULT NULL,
  `q_end` int(11) DEFAULT NULL,
  `s_start` int(11) DEFAULT NULL,
  `s_end` int(11) DEFAULT NULL,
  `evalue` float DEFAULT NULL,
  `bit` int(11) DEFAULT NULL,
  `datum` datetime DEFAULT NULL
);
