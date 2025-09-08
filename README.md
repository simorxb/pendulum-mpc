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

## Extended Kalman Filter
Often, the state is not all measured, but it is all needed by the MPC algorithm.

Let's assume we can only measure $\theta$ and not $\dot{\theta}$. To set up the Kalman Filter we need a discrete-time state space model.

### Extended Kalman Filter Model

Discrete-time form:

$x_1(k+1) = x_1(k) + T_s x_2(k)$

$x_2(k+1) = x_2(k) + T_s \frac{u(k) - k x_2(k) - m g l \sin(x_1(k))}{m l^2}$

$y(k) = x_1(k)$

### How to run the model with the EKF

- `init.m`
- `init_Kalman.m`
- `run_model_kalman.m`

### Simulation

The controller successfully tracks target positions at **0°, 90°, 180°, and 270°** and the EKF estimates are accurate and allow a stable feedback loop.
However:
- Steady-state errors are observed at **90°** and **270°** due to model simplifications.

## Extended Kalman Filter and Input Disturbance Estimation

### State-Space Representation including Disturbance Model
For MPC design:
- **States**: $x = [\theta \ \ \dot{\theta} \ \ \tau_d]^T$  
- **Input**: $u = [\tau \dot{\tau}_d]^T$  

State equations:

$\dot{x}_1 = x_2$

$\dot{x}_2 = \frac{u - k x_2 - m g l \sin(x_1)}{m l^2}$

$\dot{x}_3 = u_2$

Output:

$y = x_1$

### Extended Kalman Filter Model

We still assume that we can only measure $\theta$ and not $\dot{\theta}$. To set up the Kalman Filter we need a discrete-time state space model.

Discrete-time form:

$x_1(k+1) = x_1(k) + T_s x_2(k)$

$x_2(k+1) = x_2(k) + T_s \frac{u(k) - k x_2(k) - m g l \sin(x_1(k))}{m l^2}$

$x_3(k+1) = x_3(k) + T_s u_2(k)$

$y(k) = x_1(k)$

### How to run the model with the EKF and the disturbance estimation

- `init_aug.m`
- `init_Kalman_Aug.m`
- `run_model_kalman_augmented.m`

### Simulation

The controller successfully tracks target positions at **0°, 90°, 180°, and 270°** and the EKF estimates are accurate and allow a stable feedback loop. The disturbance model has eliminated the control offset previously observed.

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
