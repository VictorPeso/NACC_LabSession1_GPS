# GPS Satellite Ground Track Computation

This repository contains the MATLAB implementation developed for the laboratory session **"Ground Track of GPS Satellites"** of the course *Navegación Aérea, Cartografía y Cosmografía*.

The objective of the project is to compute and visualize the ground track of a GPS satellite using the orbital parameters provided in the YUMA almanac.

---

## Project Description

The implemented algorithm propagates the satellite orbit starting from the Keplerian elements contained in the GPS almanac. The computation follows the standard orbital mechanics procedure:

1. Compute the elapsed time from the Time of Applicability (ToA).
2. Propagate the Mean Anomaly.
3. Solve Kepler's equation iteratively to obtain the Eccentric Anomaly.
4. Compute the True Anomaly.
5. Determine the satellite position in the orbital plane.
6. Transform orbital coordinates into ECEF coordinates.
7. Convert ECEF coordinates into geodetic latitude and longitude.
8. Compute the sub-satellite point.
9. Generate the complete satellite ground track.

The results are visualized on a world map showing the satellite trajectory.

---

## Repository Structure

```
.
├── main1.m # Main script
├── mean_anomaly.m # Mean anomaly computation
├── eccentric.m # Eccentric anomaly (Kepler equation solver)
├── true_anomaly.m # True anomaly computation
├── orbitcoords.m # Orbital plane coordinates
├── satecef.m # Transformation to ECEF coordinates
├── subsatellite.m # Sub-satellite point computation
├── main1.dat # Debugging file generated during execution
└── README.md
```

---

## Requirements

To run the code you need:

- **MATLAB**
- Internet connection (required for downloading the GPS almanac)

The project also uses the following provided functions:

- `plotworld()`
- `gpstime()`
- `JDfromUTC()`
- `world_110m.txt`

---

## How to Run

1. Clone the repository:

git clone https://github.com/yourusername/repository-name.git

2. Open the project folder in MATLAB.

3. Run the main script:

```
main1
```

The script will compute the satellite position and display the corresponding ground track on the world map.

---

## Results

The program produces:

- The **sub-satellite point** at the selected epoch.
- The **complete ground track** of the satellite.
- A debugging file (`main1.dat`) containing intermediate computed values.

---

## Authors

Victor Peso Keyer  
Queralt Pradas Perez  

Navegación Aérea, Cartografía y Cosmografía  
UPC - EETAC - Course QP2526
