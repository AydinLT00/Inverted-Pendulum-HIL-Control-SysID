# Modeling, System Identification and Control of an Inverted Pendulum on Cart
By Group 3 | Politecnico di Milano 

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b-blue.svg)](https://www.mathworks.com/products/matlab.html)
[![Simulink](https://img.shields.io/badge/Simulink-Modeling-orange.svg)](https://www.mathworks.com/products/simulink.html)
[![Control Theory](https://img.shields.io/badge/Control-LQR%20%7C%20SMC%20%7C%20PID-green.svg)](#)
![alt text](https://img.shields.io/badge/State%20Estimation-Kalman%20Filter%20%7C%20Luenberger-orange.svg)
![alt text](https://img.shields.io/badge/Hardware-TI%20LaunchPad-red.svg)

This project details the complete design cycle—from first-principles physics to real-time hardware implementation—of a control system for an inverted pendulum on a cart. 

## 📺 Project Showreel
| Sw





ing-Up & Stabilization (Simulation) | Hardware Stabilization (LQR + Kalman) |
|---|---|
| ![Swing-Up Video](https://github.com/user-attachments/assets/e811a745-80bd-4b9e-8334-133911a1600d) | ![Hardware Video](link-to-your-hardware-video.gif) |
*(Place your videos/GIFs here. If they are large, host them on YouTube or upload as .mp4/GIF to the repo)*

---

## 🚀 Overview
The goal was to design a system capable of:
1. **Swing-up:** Transitioning the pendulum from a stable hanging position to an unstable upright position.
2. **Balancing:** Maintaining the pendulum upright despite external disturbances.
3. **Cart Positioning:** Keeping the cart centered on a finite track.

## 🛠️ Technical Workflow

### 1. Mathematical Modeling
We derived the non-linear equations of motion using **Lagrangian Mechanics**.
- **States:** $[x, \dot{x}, \theta, \dot{\theta}]^T$
- **Linearization:** Performed around both the "Hanging" and "Upright" equilibrium points to develop state-space representations for linear control.

### 2. System Identification (Experimental)
A critical phase of the project involved identifying "black box" parameters from the physical hardware:
- **Velocity Decay Analysis:** Calculated viscous damping ($b = 27.1 \, Ns/m$).
- **Steady-State Analysis:** Identified the motor force constant ($K_f$) and mapped the **deadzone** of the DC motor.
- **Sensor Calibration:** Calibrated raw encoder counts to metric units and potentiometer voltage to radians.

### 3. State Estimation
Since only position ($x$) and angle ($\theta$) were measured directly, we implemented:
- **Luenberger Observer:** Fast response but sensitive to measurement noise and spikes.
- **Steady-State Kalman Filter:** Provided superior noise rejection, effectively filtering high-frequency interference from the DC motor.

### 4. Control Strategies
- **LQR (Linear Quadratic Regulator):** Optimized via Bryson’s Rule for optimal balancing performance.
- **SMC (Sliding Mode Control):** Implemented for its robustness against model uncertainties.
- **Bang-Bang Control:** A heuristic energy-pumping algorithm used for the swing-up maneuver.

## 📊 Results & Validation
The project achieved a "Digital Twin" level of accuracy. By incorporating sensor bias and realistic noise injection into Simscape, our simulation results closely mirrored the experimental hardware data.

| Cart Position Tracking | Pendulum Angle Noise Rejection |
|---|---|
| ![Figure 5.8](path/to/screenshot_of_fig_5_8.png) | ![Figure 5.18](path/to/screenshot_of_fig_5_18.png) |

## ⚠️ Challenges & Lessons Learned
- **Hardware Limitations:** The swing-up maneuver, while successful in simulation, faced challenges on hardware due to the limited computational power of the TI LaunchPad when running complex estimators like the UKF.
- **Signal Integrity:** Dealing with electrical interference from the motor on the analog potentiometer required a transition from a Luenberger observer to a more robust Kalman Filter.

## 👥 The Team
*   **Aidin Latifi**
*   **Thomas Monaco**
*   **Edoardo Meris**

**Professor:** Jacopo Marconi  
**Institution:** Politecnico di Milano, 2025/26
