--Create trip_fact table
BEGIN 
    DROP TABLE trip_fact
END
GO;



--Create trip_fact table
CREATE TABLE trip_fact (
    [trip_id] VARCHAR(50) NOT NULL,
    [rider_id] INTEGER,
    [start_station_id] VARCHAR(50), 
    [end_station_id] VARCHAR(50), 
    [start_time_id] DATETIME2, 
    [end_time_id] DATETIME2, 
    [rideable_type] VARCHAR(75),
    [duration] VARCHAR(75),
    [rider_age] VARCHAR(75)
);

ALTER TABLE trip_fact add CONSTRAINT PK_trip_fact_trip_id PRIMARY KEY NONCLUSTERED (trip_id) NOT ENFORCED


INSERT INTO trip_fact (
    [trip_id],
    [rider_id],
    [start_station_id], 
    [end_station_id], 
    [start_time_id], 
    [end_time_id], 
    [rideable_type],
    [duration],
    [rider_age])
SELECT 
    staging_trip.trip_id,
    staging_rider.rider_id,
    staging_trip.start_station_id, 
    staging_trip.end_station_id, 
    staging_trip.start_at,                                                 
    staging_trip.ended_at,                                                   
    staging_trip.rideable_type,
    DATEDIFF(MINUTE, CAST(staging_trip.start_at AS DATETIME2), CAST(staging_trip.ended_at  AS DATETIME2))      AS duration,
    DATEDIFF(YEAR, staging_rider.birthday,
        CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120)) - (
            CASE WHEN MONTH(staging_rider.birthday) > MONTH(CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120))
            OR MONTH(staging_rider.birthday) =
                MONTH(CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120))
            AND DAY(staging_rider.birthday) >
                DAY(CONVERT(DATETIME, SUBSTRING([start_at], 1, 19),120))
            THEN 1 ELSE 0 END
    ) AS rider_age

FROM staging_trip

JOIN time_dim AS start_time     ON FORMAT(CAST(staging_trip.start_at AS DATETIME2),'yyyyMMdd') = start_time.time_id
JOIN staging_rider             ON staging_rider.rider_id = staging_trip.rider_id