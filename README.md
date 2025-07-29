# Nonlinear Model Predictive Control for Pendulum Position Control

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=simorxb/pendulum-mpc)

## Summary
This project implements a **Nonlinear Model Predictive Control (MPC)** algorithm to control the angular position of a pendulum. The system is modeled using **Simscape** for physical validation and **MATLAB/Simulink** for the control design.

## Project Overview
This repository contains the implementation of a nonlinear MPC controller designed for a pendulum system. The dynamic model is derived from **Newton's second law for rotation** and expressed in a simplified **state-space form**, allowing control using MATLAB's `nlmpc` object.  

### Pendulum System Parameters
- **Ball radius**: $r = 0.06 \ \mathrm{m}$  
- **Rod length**: $l = 1 \ \mathrm{m}$  
- **Rod diameter**: $d = 0.01 \ \mathrm{m}$  
- **Joint damping coefficient**: $k = 0.8 \ \mathrm{N·m·s}$  
- **Density (steel)**: $\rho = 7750 \ \mathrm{kg/m^3}$  
- **Gravity**: $g = 9.81 \ \mathrm{m/s^2}$  

The physical pendulum is modeled in **Simscape** for accurate validation of the control algorithm.

### Mathematical Model for MPC
The rotational dynamics are derived as:

$\sum_i \tau_i = J \ddot{\theta}$

Substituting for the pendulum:

$\tau - k \dot{\theta} - m g l \sin(\theta) = J \ddot{\theta} \quad \text{where} \quad J = m l^2$

Rearranged for angular acceleration:

$\ddot{\theta} = \frac{\tau - k \dot{\theta} - m g l \sin(\theta)}{m l^2}$

### State-Space Representation
For MPC design:
- **States**: $x = [\theta \ \ \dot{\theta}]^T$  
- **Control input**: $u = \tau$  

State equations:

$\dot{x}_1 = x_2$

$\dot{x}_2 = \frac{u - k x_2 - m g l \sin(x_1)}{m l^2}$

Output:

$y = x_1$

### MPC Design & Tuning
- **Weights**:  
  - Output variable: 1  
  - Manipulated variable: 0  
  - Manipulated variable rate: 0.03  
- **Constraints**:  
  - Torque input: $[-100, 100] \ \mathrm{N·m}$  
- **MPC parameters**:  
  - Sample time: 0.1 s  
  - Prediction horizon: 15  
  - Control horizon: 5  

### Simulation
The **nonlinear MPC** is implemented in MATLAB and Simulink. The controller successfully tracks target positions at **0°, 90°, 180°, and 270°**.  
However:
- Steady-state errors are observed at **90°** and **270°** due to model simplifications.  
- All system states are assumed measurable; future work will address **state estimation** when full state feedback is unavailable.

## Repository Structure
- **Simscape Model**: Pendulum physical system.
- **MATLAB Scripts**: State-space modeling, nonlinear MPC design, and execution.
- **Simulink Model**: Integrated simulation for validation.
- **Plotting Scripts**: Visualization of response and control signals.

## Keywords
Nonlinear MPC, Pendulum Control, Simscape, MATLAB, Simulink, State-Space Modeling, Control Systems, Predictive Control.

## Author
This project is developed by Simone Bertoni. Learn more on my personal website - [Simone Bertoni - Control Lab](https://simonebertonilab.com/).

## Contact
For further communication, connect with me on [LinkedIn](https://www.linkedin.com/in/simone-bertoni-control-eng/).
