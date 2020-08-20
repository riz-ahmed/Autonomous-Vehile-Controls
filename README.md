# Autonomous-Vehile-Controls
Remote Git repository for Project "Autonomous vehicle controls". 
Vehicle models and control algorithm are developed using Matlab / Simulink

The vehicle model is developed in the state-space form which makes it easier to develop controls using modern state-feedback controls.

A linearized vehicle model is developed using a single track model. For this linearized model, a successfull control is implementation in a model based approach in the following order:

<ul>
  <li>Non - linear model of vehicle is developed as per the dynamics of th system</li>
  <li>A single track linearized vehicle model is developed using Linearization technique</li>
  <li>State-Space model of the system is developed with states lateral motion and orientation of the vehicle and steering angle as the input u(t), the system output y(t) is the orientation angle itself</li>
  <li>Controllability analysis is conducted and made sure that the system is controllable and control law u(t) can essentailly control each of the Eigen- Vales individually in order to stabilitze the system</li>
  <li>Observability analysis is onducted in order to check that if the system is observable</li>
  <li>Kalman Filter is used as a soft sensor in order to predict missing states required for full - state feed-back control design</li>
  <li>Full state feedback controller is implemented as per the law:  <MATH>u(t) = -Kx(t) - K_{I}z(t) + k_{r}r(t)</MATH></li>
  <li>For a simple case, the controller as mentioned above is tuned using Pole Placement Technique</li>
  <li>In the next stage a LQR based tuning tehnique is employed</li>
  <li>A reference signal <MATH>r(t)</MATH> is used as an input for achieveing reference tracking objective for the given contoller design, paths are generated and given as input <MATH>r(t)</MATH> for the system to follow and achieve the desired results </li>
</ul>

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
