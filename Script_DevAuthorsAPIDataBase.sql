USE master
GO

--=======================================================================
-- Database creation ----------------------------------------------------
--=======================================================================

IF EXISTS(SELECT * FROM SysDataBases WHERE name='DevAuthorsAPIDB')
	ALTER DATABASE DevAuthorsAPIDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	GO
	DROP DATABASE DevAuthorsAPIDB
GO

CREATE DATABASE DevAuthorsAPIDB
GO

USE DevAuthorsAPIDB
GO

--=======================================================================
-- Tables Creation--- ---------------------------------------------------
--=======================================================================
drop table Author
CREATE TABLE Author (
    AuthorId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    AuthorName NVARCHAR(100) NOT NULL CHECK (AuthorName NOT LIKE '%[^a-zA-Z·¡È…ÌÕÛ”˙⁄Ò_.,'' -]%'),
    Country NVARCHAR(50) CHECK (Country NOT LIKE '%[^a-zA-Z·¡È…ÌÕÛ”˙⁄Ò_.,'' -]%'),
    BirthDate DATE,
    Website NVARCHAR(255),
    Bio NVARCHAR(1000)
);
GO

CREATE TABLE Book (
    BookId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Title NVARCHAR(200) NOT NULL,
    PublishedYear INT,
    ISBN NVARCHAR(20) UNIQUE,
    Publisher NVARCHAR(100),
    BookDescription NVARCHAR(1000)
);



CREATE TABLE AuthorBook (
    AuthorId UNIQUEIDENTIFIER NOT NULL,
    BookId UNIQUEIDENTIFIER NOT NULL,
	
    PRIMARY KEY (AuthorId, BookId),
    FOREIGN KEY (AuthorId) REFERENCES Author(AuthorId) ON DELETE CASCADE,
    FOREIGN KEY (BookId) REFERENCES Book(BookId) ON DELETE CASCADE
);

CREATE TABLE UserCredentials (
    UserId INT PRIMARY KEY,
    UserName VARCHAR(16) NOT NULL UNIQUE CHECK (Username NOT LIKE '%[^a-zA-Z·¡È…ÌÕÛ”˙⁄Ò0-9_. -]%'),	
    UserPassword VARBINARY(128) NOT NULL,
	UserEmail VARCHAR(50) NOT NULL UNIQUE CHECK (UserEmail NOT LIKE '%[^a-zA-Z·¡È…ÌÕÛ”˙⁄Ò0-9@-_. ]%'),
);
GO

------------------------------------------------------------------------- 

CREATE TABLE SecurityKeys (
    Id INT PRIMARY KEY IDENTITY(1,1),
    KeyName VARCHAR(50) UNIQUE NOT NULL,
    CipherKey NVARCHAR(255) NOT NULL
);
GO

INSERT INTO SecurityKeys (KeyName, CipherKey)
VALUES ('DevAuthorsAPISecretKey','a9pROITsEbz+XovrLeKjremzl6EJMRT2DH3pu88t9K5=');
GO

--=======================================================================
-- Stored Procedures-----------------------------------------------------
--=======================================================================

CREATE OR ALTER PROCEDURE dbo.GetBookById
	@ISBN NVARCHAR(20)
AS 
BEGIN
	IF NOT EXISTS(SELECT 1 FROM Book WHERE ISBN=@ISBN)
	BEGIN
		RAISERROR ('Error: The book does not exist.', 16, 1);
		RETURN -2
	END

	SELECT * FROM Book
	WHERE ISBN=@ISBN
	
END
GO

--======================================================================= 
-- Sample data ----------------------------------------------------------
--=======================================================================
-- Insertar Autores
INSERT INTO Author (AuthorId, AuthorName, Country, BirthDate, Website, Bio) VALUES
  (NEWID(), 'Robert C. Martin', 'USA', '1952-12-05', 'https://cleancoder.com', 'Autor de "Clean Code" y defensor de las buenas pr·cticas en desarrollo de software.'),
  (NEWID(), 'Martin Fowler', 'UK', '1963-12-18', 'https://martinfowler.com', 'Experto en patrones de arquitectura y diseÒo de software.'),
  (NEWID(), 'Kent Beck', 'USA', '1961-03-03', 'https://www.kentbeck.com', 'Creador de Extreme Programming y TDD.'),
  (NEWID(), 'Eric Evans', 'USA', '1965-05-10', 'https://domainlanguage.com', 'Autor de "Domain-Driven Design".'),
  (NEWID(), 'Donald Knuth', 'USA', '1938-01-10', 'https://www-cs-faculty.stanford.edu/~knuth/', 'Conocido por "The Art of Computer Programming".');

-- Insertar Libros
INSERT INTO Book (BookId, Title, PublishedYear, ISBN, Publisher, BookDescription) VALUES
  (NEWID(), 'Clean Code', 2008, '978-0132350884', 'Prentice Hall', 'GuÌa para escribir cÛdigo limpio y mantenible.'),
  (NEWID(), 'Refactoring', 1999, '978-0201485677', 'Addison-Wesley', 'TÈcnicas para mejorar el diseÒo del cÛdigo existente.'),
  (NEWID(), 'Test Driven Development: By Example', 2002, '978-0321146533', 'Addison-Wesley', 'IntroducciÛn pr·ctica a TDD.'),
  (NEWID(), 'Domain-Driven Design', 2003, '978-0321125217', 'Addison-Wesley', 'Conceptos clave para modelar software de manera efectiva.'),
  (NEWID(), 'The Art of Computer Programming', 1968, '978-0201896831', 'Addison-Wesley', 'Serie de libros fundamentales sobre algoritmos y estructuras de datos.');

-- RelaciÛn Autor - Libro
INSERT INTO AuthorBook (AuthorId, BookId) VALUES
  ((SELECT AuthorId FROM Author WHERE AuthorName = 'Robert C. Martin'), (SELECT BookId FROM Book WHERE Title = 'Clean Code')),
  ((SELECT AuthorId FROM Author WHERE AuthorName = 'Martin Fowler'), (SELECT BookId FROM Book WHERE Title = 'Refactoring')),
  ((SELECT AuthorId FROM Author WHERE AuthorName = 'Kent Beck'), (SELECT BookId FROM Book WHERE Title = 'Test Driven Development: By Example')),
  ((SELECT AuthorId FROM Author WHERE AuthorName = 'Eric Evans'), (SELECT BookId FROM Book WHERE Title = 'Domain-Driven Design')),
  ((SELECT AuthorId FROM Author WHERE AuthorName = 'Donald Knuth'), (SELECT BookId FROM Book WHERE Title = 'The Art of Computer Programming'));
