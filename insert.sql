
-- calls

CREATE TABLE `f_mdt_calls` (
  `reason` longtext DEFAULT NULL,  
  `time` timestamp NULL DEFAULT current_timestamp(), 
  `location` longtext DEFAULT NULL, 
  `vector` longtext DEFAULT NULL, 
  `code` longtext DEFAULT NULL, 
  `infos` longtext DEFAULT NULL, 
  `identifier` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `f_mdt_calls`
  ADD PRIMARY KEY (`identifier`);

ALTER TABLE `f_mdt_calls`
  MODIFY `identifier` int(11) NOT NULL AUTO_INCREMENT;

-- weapons

CREATE TABLE `f_mdt_weapons` (
  `owner` longtext DEFAULT NULL,  
  `type` longtext DEFAULT NULL,  
  `serial` varchar(50) DEFAULT NULL,
  `wanted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `f_mdt_weapons`
  ADD PRIMARY KEY (`serial`);

-- infos

CREATE TABLE `f_mdt_infos` (
  `header` longtext DEFAULT NULL, 
  `text` longtext DEFAULT NULL, 
  `identifier` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `f_mdt_infos`
  ADD PRIMARY KEY (`identifier`);

ALTER TABLE `f_mdt_infos`
  MODIFY `identifier` int(11) NOT NULL AUTO_INCREMENT;


-- vehicles

CREATE TABLE `f_mdt_vehicles` (
  `categorie` varchar(46) DEFAULT NULL, 
  `label` varchar(46) DEFAULT NULL, 
  `mingrade` varchar(46) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `identifier` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `f_mdt_vehicles`
  ADD PRIMARY KEY (`identifier`);

ALTER TABLE `f_mdt_vehicles`
  MODIFY `identifier` int(11) NOT NULL AUTO_INCREMENT;

-- outfits

CREATE TABLE `f_mdt_outfits` (
  `label` varchar(46) DEFAULT NULL, 
  `mingrade` varchar(46) DEFAULT NULL,
  `unit` varchar(46) DEFAULT NULL,
  `url` LONGTEXT DEFAULT NULL,
  `outfit` LONGTEXT NOT NULL DEFAULT '[]',
  `identifier` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `f_mdt_outfits`
  ADD PRIMARY KEY (`identifier`);

ALTER TABLE `f_mdt_outfits`
  MODIFY `identifier` int(11) NOT NULL AUTO_INCREMENT;

-- todos

CREATE TABLE `f_mdt_todos` (
  `label` varchar(46) DEFAULT NULL, 
  `description` longtext DEFAULT NULL,
  `officer` varchar(46) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `f_mdt_todos`
  ADD PRIMARY KEY (`identifier`);

ALTER TABLE `f_mdt_todos`
  MODIFY `identifier` int(11) NOT NULL AUTO_INCREMENT;

-- trainings

CREATE TABLE `f_mdt_trainings` (
  `label` varchar(46) DEFAULT NULL, 
  `description` longtext DEFAULT NULL,
  `supervisor` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `location` longtext DEFAULT NULL,
  `list` longtext DEFAULT NULL,
  `limit` varchar(46) NOT NULL DEFAULT 10,
  `identifier` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

ALTER TABLE `f_mdt_trainings`
  ADD PRIMARY KEY (`identifier`);

ALTER TABLE `f_mdt_trainings`
  MODIFY `identifier` int(11) NOT NULL AUTO_INCREMENT;

-- users & weapons

ALTER TABLE `users` 
    ADD COLUMN `img` LONGTEXT NOT NULL DEFAULT '',
    ADD COLUMN `warrant` LONGTEXT NOT NULL DEFAULT '{"state":false,"infos":"n/A","reason":"n/A"}',
    ADD COLUMN `editinfo` LONGTEXT NOT NULL DEFAULT '{"telefon":"n/A","email":"n/A","job":"n/A"}',
    ADD COLUMN `callNumber` int(11) NOT NULL DEFAULT 999,
    ADD COLUMN `badgeNumber` varchar(10) NOT NULL DEFAULT 'n/A',
    ADD COLUMN `unit` varchar(46) NOT NULL DEFAULT 'patrol',
    ADD COLUMN `notes` LONGTEXT NOT NULL DEFAULT '[]',
    ADD COLUMN `opened_files` LONGTEXT NOT NULL DEFAULT '[]',
    ADD COLUMN `closed_files` LONGTEXT NOT NULL DEFAULT '[]',
    ADD COLUMN `info` LONGTEXT NOT NULL DEFAULT '',
    ADD COLUMN `trainings` LONGTEXT NOT NULL DEFAULT '[]',
    ADD COLUMN `permission` int(11) NOT NULL DEFAULT 0;

ALTER TABLE `owned_vehicles` 
    ADD COLUMN `registered` int(11) NOT NULL DEFAULT 0,
    ADD COLUMN `wanted` int(11) NOT NULL DEFAULT 0;

ALTER TABLE `job_grades` 
    ADD COLUMN `permissions` LONGTEXT NOT NULL DEFAULT '{"citizenEditFile":false,"editListVehicle":false,"createListOutfit":false,"openTracking":false,"citizenOpenVehicles":false,"openWeapons":false,"editPermissions":false,"openVehicles":false,"citizenEditNote":false,"dispatchEditDispatch":false,"editListTodo":false,"openDashboard":false,"trackPlate":false,"openSettings":false,"citizenCreateFile":false,"createInformation":false,"createListVehicle":false,"checkListTraining":false,"openCalculator":false,"createListTodo":false,"openControlCenter":false,"citizenEditWanted":false,"createListTraining":false,"openDispatches":false,"trackNumber":false,"citizenOpenWeapons":false,"editListOutfit":false,"editListTraining":false,"dispatchEditOfficer":false,"citizenEditLicense":false,"citizenCreateNote":false,"citizenEditPersonalData":false,"openLists":false,"checkListTodo":false,"createListEmployee":false,"openCitizen":false,"editListEmployee":false}';


