# Autonomous-Vehile-Controls
Remote Git repository for Project "Autonomous vehicle controls". 
Vehicle models and control algorithm are developed using Matlab / Simulink

The vehicle model is developed in the state-space form which makes it easier to develop controls using modern state-feedback controls.

A linearized vehicle model is developed using a single track model. For this linearized model, a successfull control is implementation in a model based approach in the following order:
1. Dynamic analysis of the vehilce model and realizing paramters that are important for control
2. Observablitiy and controlability analysis is conduted
3. An observer model is developed using a Kalman Filter to observe required states of the vehicle model.
4. Simple control is developed using pole-placement method (Ackermann's Formula)
5. LQR and MPC controls are developed in the final phase and tested using various random trajectories as the reference for the vehicle's path to be controllerd.

[To be Considered later during the project]
Using the controls developed for the lienarized vehcile model, a non-liear vehicle mdoel is used whcih will be developed analytically that consists of a non-holonomically constrained wheel (which makes the system non-lienar). The results to be pubished later.

<b>Controller Tuning using Pole Placement</b>

Script file VehicleSteering_PolePlacement.m is used, model file is Vehicle_Steering_sim_PolePlacement.slx

<b>Controller Tuning using LQR</b>

Script file VehicleSteering_LQR.m is used, model file is Vehicle_Steering_sim_PolePlacement.slx
