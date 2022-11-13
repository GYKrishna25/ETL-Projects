-- 4th Table
create table AgentType(			
AgentTypeID	INT Identity(1,1),
AgentTypeName	Varchar(255),
AgentTypeCode varchar(255),
primary key(AgentTypeId))
 

  Create table Agent(		
	AgentID	INT IDENTITY(1,1),	
	FirstName	Varchar(255),
	MiddleName	Varchar(255),
	LastName	Varchar(255),
	AgentTypeID	INT,	
	AgentCode	Varchar(10)	,
	CreatedDate	DateTime default sysdatetime(),	
	CreatedBY	Varchar(255) DEFAULT HOST_NAME(),
	ModifiedDate Datetime,	
	ModifiedBy Varchar(255),
	primary key(AgentID));	
	go

create trigger tr_Agent_updateModifiedDate_ModifiedBy
on dbo.agent
after update
as
update dbo.Agent 
set ModifiedDate=CURRENT_TIMESTAMP, ModifiedBy=HOST_NAME() where agentid in (select AgentID from inserted)
go

-- 2ND TABLE
drop table if exists address
create table Address(			
	AddressID INT PRIMARY KEY IDENTITY(1,1),
	Agent_ID	INT,
	AddressLine1	Varchar(255),	
	AddressLine2	Varchar(255),	
	PostalCode	nvarchar(255),	
	CreatedDate	DateTime,	
	CreatedBY	Varchar(255),	
	ModifiedDate	Datetime,	
	ModifiedBy	Varchar(255),
	FOREIGN KEY(Agent_ID) references Agent(AgentID) on delete cascade);
go

create trigger tr_Address_updateModifiedDate_ModifiedBy
on [dbo].[Address]
after update
as
update dbo.Address
set ModifiedDate=CURRENT_TIMESTAMP, ModifiedBy=HOST_NAME() where AddressID in (select [AddressID] from inserted)
go 

	----- 3rd table 

CREATE TABLE PostalAddress(			
	PostalCode Nvarchar(255),	
	City	Varchar(255),	
	State	Varchar(255),	
	Country	Varchar(255),
	CreatedDate	DateTime,	
	CreatedBy	Varchar(255),	
	PRIMARY KEY(PostalCode));

select * from [dbo].[Agent]
select * from Address
select * from PostalAddress
select * from [dbo].[AgentType]