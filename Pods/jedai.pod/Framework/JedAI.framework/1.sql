CREATE TABLE IF NOT EXISTS ActivityHistory
    (_id INTEGER PRIMARY KEY,
    StartLocationId INTEGER,
    StopLocationId INTEGER,
    ActivityType INTEGER,
    Confidence INTEGER,
    VehicleType INTEGER,
    Role INTEGER,
    ExtendedInfo INTEGER,
    StartTimestamp INTEGER,
    StartTimestampLocal INTEGER,
    StopTimestamp INTEGER,
    StopTimestampLocal INTEGER
);

CREATE TABLE IF NOT EXISTS Location
(
    _id                   INTEGER PRIMARY KEY,
    LocationTime          INTEGER,
    LocationTimeLocal     INTEGER,
    LocationTimeSinceBoot INTEGER,
    Latitude              REAL,
    Longitude             REAL,
    Accuracy              REAL,
    Altitude              REAL,
    Speed                 REAL,
    Bearing               REAL,
    Provider              TEXT,
    Floor                 INTEGER,
    VerticalAccuracy      REAL,
    NetCountry            TEXT,
    SimCountry            TEXT,
    Barometer             REAL,
    DeltaStepsCounted     INTEGER
);

CREATE TABLE IF NOT EXISTS VisitedPois
(
    _id             INTEGER PRIMARY KEY,
    Name            TEXT,
    Type            TEXT,
    Tags            TEXT,
    Tag             TEXT,
    Value           TEXT,
    CenterLatitude  REAL,
    CenterLongitude REAL,
    Domain          INTEGER,
    Priority        INTEGER,
    Polygon         BLOB
);

CREATE TABLE IF NOT EXISTS Visit
(
    _id                  INTEGER PRIMARY KEY,
    EnterTimestamp       INTEGER,
    ExitTimestamp        INTEGER,
    EnterTimestampLocal  INTEGER,
    ExitTimestampLocal   INTEGER,
    Latitude             REAL,
    Longitude            REAL,
    Accuracy             REAL,
    Altitude             REAL,
    PoiId                INTEGER,
    NetCountry           TEXT,
    SimCountry           TEXT
);
