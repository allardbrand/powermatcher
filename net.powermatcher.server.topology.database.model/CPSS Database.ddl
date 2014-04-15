--<ScriptOptions statementTerminator=";"/>

ALTER TABLE CPSS.AgentEquipmentRel DROP CONSTRAINT AgentEquipmentRel_InstalledEquipment_FK;

ALTER TABLE CPSS.InstalledEquipment DROP CONSTRAINT InstalledEquipment_EquipmentType_FK;

ALTER TABLE CPSS.InstalledEquipment DROP CONSTRAINT InstalledEquipment_Location_FK;

ALTER TABLE CPSS.InstalledEquipmentRel DROP CONSTRAINT InstalledEquipmentRel_Child_FK;

ALTER TABLE CPSS.InstalledEquipmentRel DROP CONSTRAINT InstalledEquipmentRel_Parent_FK;

ALTER TABLE CPSSMETA.ControlType DROP CONSTRAINT ControlType_EquipmentType_FK;

ALTER TABLE CPSSMETA.EquipmentAttribute DROP CONSTRAINT EquipmentAttribute_EquipmentAttributeType_FK;

ALTER TABLE CPSSMETA.EquipmentAttribute DROP CONSTRAINT EquipmentAttribute_InstalledEquipment_FK;

ALTER TABLE CPSSMETA.EquipmentAttributeType DROP CONSTRAINT EquipmentAttributeType_EquipmentType_FK;

ALTER TABLE CPSSMETA.EquipmentTypeAttribute DROP CONSTRAINT EquipmentAttributes_EquipmentType_FK;

ALTER TABLE CPSSMETA.Location DROP CONSTRAINT Location_LocationType_FK;

ALTER TABLE CPSSMETA.Location DROP CONSTRAINT Location_Location_FK;

ALTER TABLE CPSSMETA.LocationAttribute DROP CONSTRAINT LocationAttribute_LocationAttributeType_FK;

ALTER TABLE CPSSMETA.LocationAttribute DROP CONSTRAINT LocationAttribute_Location_FK;

ALTER TABLE CPSSMETA.LocationAttributeType DROP CONSTRAINT LocationAttributeType_LocationType_FK;

ALTER TABLE CPSSMETA.LocationTypeAttribute DROP CONSTRAINT LocationTypeAttribute_LocationType_FK;

ALTER TABLE CPSSMETA.MeasurementType DROP CONSTRAINT MeasurementType_EquipmentType_FK;

ALTER TABLE CPSSMETA.StatusType DROP CONSTRAINT StatusType_EquipmentType_FK;

ALTER TABLE CPSS.AgentEquipmentRel DROP CONSTRAINT AgentEquipmentRel_PK;

ALTER TABLE CPSS.InstalledEquipment DROP CONSTRAINT InstalledEquipment_PK;

ALTER TABLE CPSS.InstalledEquipment DROP CONSTRAINT InstalledEquipment__UN;

ALTER TABLE CPSS.InstalledEquipmentRel DROP CONSTRAINT InstalledEquipmentRel_PK;

ALTER TABLE CPSSMETA.ControlType DROP CONSTRAINT ControlType_PK;

ALTER TABLE CPSSMETA.EquipmentAttribute DROP CONSTRAINT EquipmentAttribute_PK;

ALTER TABLE CPSSMETA.EquipmentAttributeType DROP CONSTRAINT EquipmentAttributeType_PK;

ALTER TABLE CPSSMETA.EquipmentType DROP CONSTRAINT EquipmentType_PK;

ALTER TABLE CPSSMETA.EquipmentTypeAttribute DROP CONSTRAINT EquipmentTypeAttributes_PK;

ALTER TABLE CPSSMETA.Location DROP CONSTRAINT Location_PK;

ALTER TABLE CPSSMETA.LocationAttribute DROP CONSTRAINT LocationAttribute_PK;

ALTER TABLE CPSSMETA.LocationAttributeType DROP CONSTRAINT LocationAttributeType_PK;

ALTER TABLE CPSSMETA.LocationType DROP CONSTRAINT LocationType_PK;

ALTER TABLE CPSSMETA.LocationTypeAttribute DROP CONSTRAINT LocationTypeAttribute_PK;

ALTER TABLE CPSSMETA.MeasurementType DROP CONSTRAINT MeasurementType_PK;

ALTER TABLE CPSSMETA.StatusType DROP CONSTRAINT StatusType_PK;

DROP INDEX CPSS.InstalledEquipmentRel_Parent_IDX;

DROP INDEX CPSS.InstalledEquipment_NamespaceLocationType_IDX;

DROP VIEW CPSS.InstalledEquipmentView;

DROP TABLE CPSS.AgentEquipmentRel;

DROP TABLE CPSS.InstalledEquipment;

DROP TABLE CPSS.InstalledEquipmentRel;

DROP TABLE CPSSMETA.ControlType;

DROP TABLE CPSSMETA.EquipmentAttribute;

DROP TABLE CPSSMETA.EquipmentAttributeType;

DROP TABLE CPSSMETA.EquipmentType;

DROP TABLE CPSSMETA.EquipmentTypeAttribute;

DROP TABLE CPSSMETA.Location;

DROP TABLE CPSSMETA.LocationAttribute;

DROP TABLE CPSSMETA.LocationAttributeType;

DROP TABLE CPSSMETA.LocationType;

DROP TABLE CPSSMETA.LocationTypeAttribute;

DROP TABLE CPSSMETA.MeasurementType;

DROP TABLE CPSSMETA.StatusType;

DROP SCHEMA CPSS RESTRICT;

DROP SCHEMA CPSSMETA RESTRICT;

CREATE SCHEMA CPSS;

CREATE SCHEMA CPSSMETA;

CREATE TABLE CPSS.AgentEquipmentRel (
		namespaceId VARCHAR(64) NOT NULL,
		agentId VARCHAR(64) NOT NULL,
		locationId VARCHAR(64),
		equipmentType VARCHAR(64),
		equipmentId VARCHAR(64)
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSS.InstalledEquipment (
		id INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY ( START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 NO CYCLE CACHE 20),
		namespaceId VARCHAR(64) NOT NULL,
		locationId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL DEFAULT '',
		equipmentId VARCHAR(64) NOT NULL,
		equipmentVersionNumber VARCHAR(64),
		equipmentSerialNumber VARCHAR(64),
		updateTimestamp TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSS.InstalledEquipmentRel (
		parentId INTEGER NOT NULL,
		childId INTEGER NOT NULL,
		startRelation TIMESTAMP NOT NULL,
		endRelation TIMESTAMP,
		workOrder VARCHAR(64),
		equipmentSubtype VARCHAR(64) NOT NULL,
		equipmentVersionNumber VARCHAR(64),
		updateTimestamp TIMESTAMP NOT NULL DEFAULT CURRENT TIMESTAMP
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.ControlType (
		namespaceId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL,
		valueName VARCHAR(64) NOT NULL,
		units VARCHAR(16) NOT NULL,
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.EquipmentAttribute (
		namespaceId VARCHAR(64) NOT NULL,
		locationId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL,
		equipmentId VARCHAR(64) NOT NULL,
		attrName VARCHAR(64) NOT NULL,
		value VARCHAR(64) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.EquipmentAttributeType (
		namespaceId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL,
		attrName VARCHAR(64) NOT NULL,
		units VARCHAR(16),
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.EquipmentType (
		namespaceId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL,
		manufacturer VARCHAR(64),
		model VARCHAR(64),
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.EquipmentTypeAttribute (
		namespaceId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL,
		attrName VARCHAR(64) NOT NULL,
		value VARCHAR(64) NOT NULL,
		units VARCHAR(16),
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.Location (
		namespaceId VARCHAR(64) NOT NULL,
		locationId VARCHAR(64) NOT NULL,
		locationType VARCHAR(64) NOT NULL,
		locationSubtype VARCHAR(64) NOT NULL,
		parentLocationId VARCHAR(64),
		name VARCHAR(64) NOT NULL,
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.LocationAttribute (
		namespaceId VARCHAR(64) NOT NULL,
		locationType VARCHAR(64) NOT NULL,
		locationSubtype VARCHAR(64) NOT NULL,
		locationId VARCHAR(64) NOT NULL,
		attrName VARCHAR(64) NOT NULL,
		value VARCHAR(64) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.LocationAttributeType (
		namespaceId VARCHAR(64) NOT NULL,
		locationType VARCHAR(64) NOT NULL,
		locationSubtype VARCHAR(64) NOT NULL,
		attrName VARCHAR(64) NOT NULL,
		units VARCHAR(16),
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.LocationType (
		namespaceId VARCHAR(64) NOT NULL,
		locationType VARCHAR(64) NOT NULL,
		locationSubtype VARCHAR(64) NOT NULL,
		name VARCHAR(64) NOT NULL,
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.LocationTypeAttribute (
		namespaceId VARCHAR(64) NOT NULL,
		locationType VARCHAR(64) NOT NULL,
		locationSubtype VARCHAR(64) NOT NULL,
		attrName VARCHAR(64) NOT NULL,
		value VARCHAR(64) NOT NULL,
		units VARCHAR(16),
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.MeasurementType (
		namespaceId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL,
		valueName VARCHAR(64) NOT NULL,
		valueType VARCHAR(16) NOT NULL,
		units VARCHAR(16) NOT NULL,
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE TABLE CPSSMETA.StatusType (
		namespaceId VARCHAR(64) NOT NULL,
		equipmentType VARCHAR(64) NOT NULL,
		equipmentSubtype VARCHAR(64) NOT NULL,
		valueName VARCHAR(64) NOT NULL,
		valueType VARCHAR(16) NOT NULL,
		description VARCHAR(128) NOT NULL
	)
	DATA CAPTURE NONE;

CREATE INDEX CPSS.InstalledEquipmentRel_Parent_IDX
	ON CPSS.InstalledEquipmentRel
	(parentId		ASC) PCTFREE 0
ALLOW REVERSE SCANS;

CREATE UNIQUE INDEX CPSS.InstalledEquipment_NamespaceLocationType_IDX
	ON CPSS.InstalledEquipment
	(namespaceId		ASC,
	  locationId		ASC,
	  equipmentType		ASC,
	  equipmentId		ASC) PCTFREE 0
ALLOW REVERSE SCANS;

ALTER TABLE CPSS.AgentEquipmentRel ADD CONSTRAINT AgentEquipmentRel_PK PRIMARY KEY
	(namespaceId,
	 agentId);

ALTER TABLE CPSS.InstalledEquipment ADD CONSTRAINT InstalledEquipment_PK PRIMARY KEY
	(id);

ALTER TABLE CPSS.InstalledEquipment ADD CONSTRAINT InstalledEquipment__UN UNIQUE
	(namespaceId,
	 locationId,
	 equipmentType,
	 equipmentId);

ALTER TABLE CPSS.InstalledEquipmentRel ADD CONSTRAINT InstalledEquipmentRel_PK PRIMARY KEY
	(parentId,
	 childId,
	 startRelation);

ALTER TABLE CPSSMETA.ControlType ADD CONSTRAINT ControlType_PK PRIMARY KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 valueName);

ALTER TABLE CPSSMETA.EquipmentAttribute ADD CONSTRAINT EquipmentAttribute_PK PRIMARY KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 equipmentId,
	 attrName,
	 locationId);

ALTER TABLE CPSSMETA.EquipmentAttributeType ADD CONSTRAINT EquipmentAttributeType_PK PRIMARY KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 attrName);

ALTER TABLE CPSSMETA.EquipmentType ADD CONSTRAINT EquipmentType_PK PRIMARY KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype);

ALTER TABLE CPSSMETA.EquipmentTypeAttribute ADD CONSTRAINT EquipmentTypeAttributes_PK PRIMARY KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 attrName);

ALTER TABLE CPSSMETA.Location ADD CONSTRAINT Location_PK PRIMARY KEY
	(namespaceId,
	 locationId);

ALTER TABLE CPSSMETA.LocationAttribute ADD CONSTRAINT LocationAttribute_PK PRIMARY KEY
	(namespaceId,
	 locationId,
	 locationType,
	 locationSubtype,
	 attrName);

ALTER TABLE CPSSMETA.LocationAttributeType ADD CONSTRAINT LocationAttributeType_PK PRIMARY KEY
	(namespaceId,
	 locationType,
	 locationSubtype,
	 attrName);

ALTER TABLE CPSSMETA.LocationType ADD CONSTRAINT LocationType_PK PRIMARY KEY
	(namespaceId,
	 locationType,
	 locationSubtype);

ALTER TABLE CPSSMETA.LocationTypeAttribute ADD CONSTRAINT LocationTypeAttribute_PK PRIMARY KEY
	(namespaceId,
	 locationType,
	 locationSubtype,
	 attrName);

ALTER TABLE CPSSMETA.MeasurementType ADD CONSTRAINT MeasurementType_PK PRIMARY KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 valueName);

ALTER TABLE CPSSMETA.StatusType ADD CONSTRAINT StatusType_PK PRIMARY KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 valueName);

ALTER TABLE CPSS.AgentEquipmentRel ADD CONSTRAINT AgentEquipmentRel_InstalledEquipment_FK FOREIGN KEY
	(namespaceId,
	 locationId,
	 equipmentType,
	 equipmentId)
	REFERENCES CPSS.InstalledEquipment
	(namespaceId,
	 locationId,
	 equipmentType,
	 equipmentId)
	ON DELETE RESTRICT;

ALTER TABLE CPSS.InstalledEquipment ADD CONSTRAINT InstalledEquipment_EquipmentType_FK FOREIGN KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	REFERENCES CPSSMETA.EquipmentType
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	ON DELETE RESTRICT
	NOT ENFORCED;

ALTER TABLE CPSS.InstalledEquipment ADD CONSTRAINT InstalledEquipment_Location_FK FOREIGN KEY
	(namespaceId,
	 locationId)
	REFERENCES CPSSMETA.Location
	(namespaceId,
	 locationId)
	ON DELETE RESTRICT
	NOT ENFORCED;

ALTER TABLE CPSS.InstalledEquipmentRel ADD CONSTRAINT InstalledEquipmentRel_Child_FK FOREIGN KEY
	(childId)
	REFERENCES CPSS.InstalledEquipment
	(id);

ALTER TABLE CPSS.InstalledEquipmentRel ADD CONSTRAINT InstalledEquipmentRel_Parent_FK FOREIGN KEY
	(parentId)
	REFERENCES CPSS.InstalledEquipment
	(id);

ALTER TABLE CPSSMETA.ControlType ADD CONSTRAINT ControlType_EquipmentType_FK FOREIGN KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	REFERENCES CPSSMETA.EquipmentType
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.EquipmentAttribute ADD CONSTRAINT EquipmentAttribute_EquipmentAttributeType_FK FOREIGN KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 attrName)
	REFERENCES CPSSMETA.EquipmentAttributeType
	(namespaceId,
	 equipmentType,
	 equipmentSubtype,
	 attrName)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.EquipmentAttribute ADD CONSTRAINT EquipmentAttribute_InstalledEquipment_FK FOREIGN KEY
	(namespaceId,
	 locationId,
	 equipmentType,
	 equipmentId)
	REFERENCES CPSS.InstalledEquipment
	(namespaceId,
	 locationId,
	 equipmentType,
	 equipmentId)
	ON DELETE RESTRICT
	NOT ENFORCED;

ALTER TABLE CPSSMETA.EquipmentAttributeType ADD CONSTRAINT EquipmentAttributeType_EquipmentType_FK FOREIGN KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	REFERENCES CPSSMETA.EquipmentType
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.EquipmentTypeAttribute ADD CONSTRAINT EquipmentAttributes_EquipmentType_FK FOREIGN KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	REFERENCES CPSSMETA.EquipmentType
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	ON DELETE CASCADE;

ALTER TABLE CPSSMETA.Location ADD CONSTRAINT Location_LocationType_FK FOREIGN KEY
	(namespaceId,
	 locationType,
	 locationSubtype)
	REFERENCES CPSSMETA.LocationType
	(namespaceId,
	 locationType,
	 locationSubtype)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.Location ADD CONSTRAINT Location_Location_FK FOREIGN KEY
	(namespaceId,
	 parentLocationId)
	REFERENCES CPSSMETA.Location
	(namespaceId,
	 locationId)
	ON DELETE RESTRICT
	NOT ENFORCED;

ALTER TABLE CPSSMETA.LocationAttribute ADD CONSTRAINT LocationAttribute_LocationAttributeType_FK FOREIGN KEY
	(namespaceId,
	 locationType,
	 locationSubtype,
	 attrName)
	REFERENCES CPSSMETA.LocationAttributeType
	(namespaceId,
	 locationType,
	 locationSubtype,
	 attrName)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.LocationAttribute ADD CONSTRAINT LocationAttribute_Location_FK FOREIGN KEY
	(namespaceId,
	 locationId)
	REFERENCES CPSSMETA.Location
	(namespaceId,
	 locationId)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.LocationAttributeType ADD CONSTRAINT LocationAttributeType_LocationType_FK FOREIGN KEY
	(namespaceId,
	 locationType,
	 locationSubtype)
	REFERENCES CPSSMETA.LocationType
	(namespaceId,
	 locationType,
	 locationSubtype)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.LocationTypeAttribute ADD CONSTRAINT LocationTypeAttribute_LocationType_FK FOREIGN KEY
	(namespaceId,
	 locationType,
	 locationSubtype)
	REFERENCES CPSSMETA.LocationType
	(namespaceId,
	 locationType,
	 locationSubtype)
	ON DELETE CASCADE;

ALTER TABLE CPSSMETA.MeasurementType ADD CONSTRAINT MeasurementType_EquipmentType_FK FOREIGN KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	REFERENCES CPSSMETA.EquipmentType
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	ON DELETE RESTRICT;

ALTER TABLE CPSSMETA.StatusType ADD CONSTRAINT StatusType_EquipmentType_FK FOREIGN KEY
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	REFERENCES CPSSMETA.EquipmentType
	(namespaceId,
	 equipmentType,
	 equipmentSubtype)
	ON DELETE RESTRICT;

CREATE VIEW CPSS.InstalledEquipmentView (id, namespaceId, locationId, equipmentType, equipmentId, equipmentSubtype, equipmentVersionNumber, equipmentSerialNumber, updateTimestamp, parentId, parentLocationId, parentEquipmentType, parentEquipmentId) AS
SELECT EQ.ID, EQ.NAMESPACEID, EQ.LOCATIONID, EQ.EQUIPMENTTYPE, EQ.EQUIPMENTID, EQ.EQUIPMENTSUBTYPE, EQ.EQUIPMENTVERSIONNUMBER, EQ.EQUIPMENTSERIALNUMBER, EQ.UPDATETIMESTAMP, EQREL.PARENTID AS PARENTID, PARENTEQ.LOCATIONID AS PARENTLOCATIONID, PARENTEQ.EQUIPMENTTYPE AS PARENTEQUIPMENTTYPE, PARENTEQ.EQUIPMENTID AS PARENTEQUIPMENTID
   FROM CPSS.INSTALLEDEQUIPMENT AS EQ LEFT OUTER JOIN CPSS.INSTALLEDEQUIPMENTREL AS EQREL ON EQ.ID = EQREL.CHILDID 
   LEFT OUTER JOIN CPSS.INSTALLEDEQUIPMENT AS PARENTEQ ON EQREL.PARENTID = PARENTEQ.ID
   WHERE EQREL.ENDRELATION IS NULL;

COMMENT ON COLUMN CPSS.AgentEquipmentRel.agentId IS
'Unique ID of the agent within the cluster.';

COMMENT ON COLUMN CPSS.AgentEquipmentRel.equipmentId IS
'The ID of the equipment.
The combination of equipmentType and equipmentId uniquely identify the equipment within the location.';

COMMENT ON COLUMN CPSS.AgentEquipmentRel.equipmentType IS
'The type of the equipment.
The combination of equipmentType and equipmentId uniquely identify the equipment within the location.';

COMMENT ON COLUMN CPSS.AgentEquipmentRel.locationId IS
'The logical or physical location of the equipment.
The location ID is unique within the namespace.';

COMMENT ON COLUMN CPSS.AgentEquipmentRel.namespaceId IS
'ID of the namespace the agent belongs to.';

COMMENT ON COLUMN CPSS.InstalledEquipment.equipmentId IS
'The ID of the equipment.
The combination of equipmentType and equipmentId uniquely identify the equipment within the location.';

COMMENT ON COLUMN CPSS.InstalledEquipment.equipmentSerialNumber IS
'The (optional) serial number of the equipment, in case the serial number is not used for the equipmentId.';

COMMENT ON COLUMN CPSS.InstalledEquipment.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSS.InstalledEquipment.equipmentType IS
'The type of the equipment.
The combination of equipmentType and equipmentId uniquely identify the equipment within the location.';

COMMENT ON COLUMN CPSS.InstalledEquipment.equipmentVersionNumber IS
'The (optional) version number of the equipment.
When the version number is updated, the latest value is found here.
The history of version numbers is captured in InstalledEquipmentRel.';

COMMENT ON COLUMN CPSS.InstalledEquipment.locationId IS
'The logical or physical location of the equipment.
The location ID is unique within the namespace.';

COMMENT ON COLUMN CPSS.InstalledEquipment.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSS.InstalledEquipment.updateTimestamp IS
'Timestamp when the row was created or updated. The timestamp is in local time.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.childId IS
'The child equipment in the relationship.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.endRelation IS
'The timestamp of the start of the relationship, in UTC.
The timestamp is null if the relationship is current.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.equipmentVersionNumber IS
'The (optional) version number of the equipment at the time of the relationship.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.parentId IS
'The parent equipment in the relationship.
For equipment that has no parent in the equipment topology in a namespace, parentId == childId.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.startRelation IS
'The timestamp of the start of the relationship, in UTC.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.updateTimestamp IS
'Timestamp when the row was created or updated. The timestamp is in local time.';

COMMENT ON COLUMN CPSS.InstalledEquipmentRel.workOrder IS
'The (optional) work order associated with the change in topology.';

COMMENT ON COLUMN CPSSMETA.ControlType.description IS
'A description of this type of control point.';

COMMENT ON COLUMN CPSSMETA.ControlType.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSSMETA.ControlType.equipmentType IS
'The type of the equipment.';

COMMENT ON COLUMN CPSSMETA.ControlType.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.ControlType.units IS
'The unit (for example "C") of the control setting.';

COMMENT ON COLUMN CPSSMETA.ControlType.valueName IS
'The ID of the control point defined for this type of equipment.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttribute.attrName IS
'The identifying name of the attribute defined for the equipement type of this equipment item.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttribute.equipmentId IS
'The ID of the equipment.
The combination of equipmentType and equipmentId uniquely identify the equipment within the location.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttribute.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttribute.equipmentType IS
'The type of the equipment.
The combination of equipmentType and equipmentId uniquely identify the equipment within the location.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttribute.locationId IS
'The ID of the logical or physical location
The location ID is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttribute.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttribute.value IS
'The value of the location attribute.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttributeType.attrName IS
'The identifying name of the attribute defined for this equipment type.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttributeType.description IS
'A description of this equipment type attribute.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttributeType.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttributeType.equipmentType IS
'The type of the equipment.
The combination of equipmentType and equipmentId uniquely identify the equipment within the location.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttributeType.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.EquipmentAttributeType.units IS
'The optional unit (for example "m3") of the attribute value.';

COMMENT ON COLUMN CPSSMETA.EquipmentType.description IS
'A description of this type of equipment.';

COMMENT ON COLUMN CPSSMETA.EquipmentType.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSSMETA.EquipmentType.equipmentType IS
'The equipment type.
The equipment type is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.EquipmentType.manufacturer IS
'The (optional) manufacturer of this equipment type.';

COMMENT ON COLUMN CPSSMETA.EquipmentType.model IS
'The (optional) model of this equipment type.';

COMMENT ON COLUMN CPSSMETA.EquipmentType.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.EquipmentTypeAttribute.attrName IS
'The identifying name of the attribute defined for this equipment type.';

COMMENT ON COLUMN CPSSMETA.EquipmentTypeAttribute.description IS
'A description of this equipment type attribute.';

COMMENT ON COLUMN CPSSMETA.EquipmentTypeAttribute.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSSMETA.EquipmentTypeAttribute.equipmentType IS
'The equipment type.
The equipment type is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.EquipmentTypeAttribute.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.EquipmentTypeAttribute.units IS
'The optional unit (for example "W") of the attribute value.';

COMMENT ON COLUMN CPSSMETA.EquipmentTypeAttribute.value IS
'The value of the equipment type attribute.';

COMMENT ON COLUMN CPSSMETA.Location.description IS
'A description of this location.';

COMMENT ON COLUMN CPSSMETA.Location.locationId IS
'The ID of the logical or physical location
The location ID is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.Location.locationSubtype IS
'The subtype of the location.';

COMMENT ON COLUMN CPSSMETA.Location.locationType IS
'The type of location.
The location type is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.Location.name IS
'Short descriptive name for this location.';

COMMENT ON COLUMN CPSSMETA.Location.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.Location.parentLocationId IS
'The ID of the logical or physical location
The location ID is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.LocationAttribute.attrName IS
'The identifying name of the attribute defined for the location type of this location.';

COMMENT ON COLUMN CPSSMETA.LocationAttribute.locationId IS
'The ID of the logical or physical location
The location ID is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.LocationAttribute.locationSubtype IS
'The subtype of the location.
The location type and subtype classify the location.';

COMMENT ON COLUMN CPSSMETA.LocationAttribute.locationType IS
'The location type.
The location type is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.LocationAttribute.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.LocationAttribute.value IS
'The value of the location attribute.';

COMMENT ON COLUMN CPSSMETA.LocationAttributeType.attrName IS
'The identifying name of the attribute defined for this location type.';

COMMENT ON COLUMN CPSSMETA.LocationAttributeType.description IS
'A description of this location type attribute.';

COMMENT ON COLUMN CPSSMETA.LocationAttributeType.locationSubtype IS
'The subtype of the location.
The location type and subtype classify the location.';

COMMENT ON COLUMN CPSSMETA.LocationAttributeType.locationType IS
'The location type.
The location type is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.LocationAttributeType.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.LocationAttributeType.units IS
'The optional unit (for example "m3") of the attribute value.';

COMMENT ON COLUMN CPSSMETA.LocationType.description IS
'A description of this type of location.';

COMMENT ON COLUMN CPSSMETA.LocationType.locationSubtype IS
'The subtype of the location.
The location type and subtype classify the location.';

COMMENT ON COLUMN CPSSMETA.LocationType.locationType IS
'The location type.
The location type is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.LocationType.name IS
'Short descriptive name for this location type.';

COMMENT ON COLUMN CPSSMETA.LocationType.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.LocationTypeAttribute.attrName IS
'The identifying name of the attribute defined for this location type.';

COMMENT ON COLUMN CPSSMETA.LocationTypeAttribute.description IS
'A description of this location type attribute.';

COMMENT ON COLUMN CPSSMETA.LocationTypeAttribute.locationSubtype IS
'The subtype of the location.
The location type and subtype classify the location.';

COMMENT ON COLUMN CPSSMETA.LocationTypeAttribute.locationType IS
'The location type.
The location type is unique within the namespace.';

COMMENT ON COLUMN CPSSMETA.LocationTypeAttribute.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.LocationTypeAttribute.units IS
'The optional unit (for example "m3") of the attribute value.';

COMMENT ON COLUMN CPSSMETA.LocationTypeAttribute.value IS
'The value of the location type attribute.';

COMMENT ON COLUMN CPSSMETA.MeasurementType.description IS
'A description of this measurement point.';

COMMENT ON COLUMN CPSSMETA.MeasurementType.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSSMETA.MeasurementType.equipmentType IS
'The type of the equipment.';

COMMENT ON COLUMN CPSSMETA.MeasurementType.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.MeasurementType.units IS
'The unit (for example "W") of the measurement.';

COMMENT ON COLUMN CPSSMETA.MeasurementType.valueName IS
'The ID of the measurement point defined for this type of equipment.';

COMMENT ON COLUMN CPSSMETA.MeasurementType.valueType IS
'The type of measurement, for example "level", "flow", "quantity" or "counter".';

COMMENT ON COLUMN CPSSMETA.StatusType.description IS
'A description of this status point.';

COMMENT ON COLUMN CPSSMETA.StatusType.equipmentSubtype IS
'The subtype of the equipment.
The equipment type and subtype identify the make and model.';

COMMENT ON COLUMN CPSSMETA.StatusType.equipmentType IS
'The type of the equipment.';

COMMENT ON COLUMN CPSSMETA.StatusType.namespaceId IS
'The namespace that the locations and equipment belong to.';

COMMENT ON COLUMN CPSSMETA.StatusType.valueName IS
'The ID of the status point defined for this type of equipment.';

COMMENT ON COLUMN CPSSMETA.StatusType.valueType IS
'The type of status, for example "enumeration", "time", etc.';

COMMENT ON TABLE CPSS.AgentEquipmentRel IS
'Agent to equipment mapping.';

COMMENT ON TABLE CPSS.InstalledEquipment IS
'Equipment that is, or has been, installed and for which event data is captured.';

COMMENT ON TABLE CPSS.InstalledEquipmentRel IS
'Topological parent-child relationship between equipment within the namespace.
A new relationship is created whenever the topology changes or equipment properties subtype or version number change.';

COMMENT ON TABLE CPSSMETA.ControlType IS
'A ControlType defines the control values for a type of equipment.';

COMMENT ON TABLE CPSSMETA.EquipmentAttribute IS
'Defines the attributes for a specific equipment item.';

COMMENT ON TABLE CPSSMETA.EquipmentAttributeType IS
'Defines the equipment-specific attributes for an equipment item of a particular subtype.';

COMMENT ON TABLE CPSSMETA.EquipmentType IS
'EquipmentType defines a subtype of equipment by its key attributes.';

COMMENT ON TABLE CPSSMETA.EquipmentTypeAttribute IS
'EquipmentTypeAttribute defines the characteristics for a particular subtype of equipment.';

COMMENT ON TABLE CPSSMETA.Location IS
'Defines a physical or logical location where equipment is installed.';

COMMENT ON TABLE CPSSMETA.LocationAttribute IS
'Defines the attributes for a specific location.';

COMMENT ON TABLE CPSSMETA.LocationAttributeType IS
'Defines the location-specific attributes for a location of a particular subtype.';

COMMENT ON TABLE CPSSMETA.LocationType IS
'LocationType defines the subtype of location by its key attributes.';

COMMENT ON TABLE CPSSMETA.LocationTypeAttribute IS
'LocationTypeAttribute defines the characteristics for a particular subtype of location.';

COMMENT ON TABLE CPSSMETA.MeasurementType IS
'A MeasurementType defines the measurement values for a type of equipment.';

COMMENT ON TABLE CPSSMETA.StatusType IS
'A StatusType defines the status values for a type of equipment.';

