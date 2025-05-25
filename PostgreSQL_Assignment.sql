-- Active: 1747551534521@@127.0.0.1@5432@conservation_db
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Historic', 'Critically Endangered'))
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id int NOT NULL,
    ranger_id int NOT NULL,
    location VARCHAR(100) NOT NULL,
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);

-- SELECT * FROM sightings;
-- DROP TABLE species;

INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range'),
(4, 'David Brooks', 'Wetland Marshes'),
(5, 'Ella Stone', 'Desert Plains'),
(6, 'Farid Khan', 'Eastern Valley');

INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
(5, 'Shadow Leopard', 'Panthera nebulosa', '1895-03-14', 'Critically Endangered'),
(6, 'Great Indian Bustard', 'Ardeotis nigriceps', '1861-01-01', 'Critically Endangered'),
(7, 'Indian Pangolin', 'Manis crassicaudata', '1821-07-01', 'Endangered'),
(8, 'Sloth Bear', 'Melursus ursinus', '1791-04-12', 'Vulnerable');

INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(5, 5, 4, 'Cloud Veil Canyon', '2024-05-20 06:10:00', 'Unclear silhouette at dawn'),
(6, 6, 5, 'Open Sandbelt Zone', '2024-05-22 08:25:00', 'Pair spotted foraging'),
(7, 7, 3, 'Lower Valley Brush', '2024-05-23 13:40:00', 'Burrow found near stream'),
(8, 2, 6, 'East Valley Track', '2024-05-24 17:55:00', 'Roar heard in distance'),
(9, 1, 1, 'High Snow Trail', '2024-05-25 07:20:00', 'Fresh paw prints found'),
(10, 8, 2, 'Hollow Tree Forest', '2024-05-25 15:30:00', 'Seen climbing tree');




-- Problem 1:
INSERT INTO rangers (ranger_id, name, region)
VALUES (7, 'Derek Fox', 'Coastal Plains');
-- SELECT * FROM rangers;

-- Problem 2: 
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3:
SELECT *
FROM sightings
WHERE location ILIKE '%Pass%';

-- Problem 4:
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;

-- Problem 5: 
SELECT s.common_name
FROM species s
LEFT JOIN sightings si ON s.species_id = si.species_id
WHERE si.species_id IS NULL;

-- Problem 6:
SELECT sp.common_name, si.sighting_time, r.name
FROM sightings si
JOIN species sp ON si.species_id = sp.species_id
JOIN rangers r ON si.ranger_id = r.ranger_id
ORDER BY si.sighting_time DESC
LIMIT 2;

-- Problem 7:
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- Problem 8:
SELECT sighting_id,
       CASE
           WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day
FROM sightings;

-- Problem 9:
DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);

-- SELECT * FROM rangers;



