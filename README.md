# Autonomous-Vehile-Controls
Remote Git repository for Project "Autonomous vehicle controls". 
Vehicle models and control algorithm are developed using Matlab / Simulink

<h2>Running the simulation</h2>
<p>
  The simulation models are all listed inside the Models folder and the corresponding scripts are linked to the simulink models, any changes in the simulation parameters canbe done directly using the individual script files associated to model files. For example, for the simulation of reference tracking contoller using LQR, find the model file models/VehicleSteering_sim_LQR.slx and the corresponding script file scripts/VehicleSteering_LQR.m
</p>

The vehicle model is developed in the state-space form which makes it easier to develop controls using modern state-feedback controls.

A linearized vehicle model is developed using a single track model. For this linearized model, a successfull control is implementation in a model based approach in the following order:

<ul>
  <li>Non - linear model of vehicle is developed as per the dynamics of th system</li>
  <li>A single track linearized vehicle model is developed using Linearization technique</li>
  <li>State-Space model of the system is developed with states lateral motion and orientation of the vehicle and steering angle as the input u(t), the system output y(t) is the orientation angle itself</li>
  <li>Controllability analysis is conducted and made sure that the system is controllable and control law u(t) can essentailly control each of the Eigen- Vales individually in order to stabilitze the system</li>
  <li>Observability analysis is onducted in order to check that if the system is observable</li>
  <li>Kalman Filter is used as a soft sensor in order to predict missing states required for full - state feed-back control design</li>
  <li>Full state feedback controller is implemented as per the law:  <img src="http://www.sciweavers.org/tex2img.php?eq=u%28t%29%20%3D%20-Kx%28t%29%20-%20K_%7BI%7Dz%28t%29%20%2B%20k_%7Br%7Dr%28t%29&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="u(t) = -Kx(t) - K_{I}z(t) + k_{r}r(t)" width="250" height="18" /></li>
  <li>For a simple case, the controller as mentioned above is tuned using Pole Placement Technique</li>
  <li>In the next stage a LQR based tuning tehnique is employed</li>
  <li>A reference signal <MATH>r(t)</MATH> is used as an input for achieveing reference tracking objective for the given contoller design, paths are generated and given as input <MATH>r(t)</MATH> for the system to follow and achieve the desired results </li>
</ul>

[To be Considered later during the project]
Using the controls developed for the lienarized vehcile model, a non-liear vehicle mdoel is used whcih will be developed analytically that consists of a non-holonomically constrained wheel (which makes the system non-lienar). The results to be pubished later.

<h3>Controller Tuning using Pole Placement</h3>

Script file VehicleSteering_PolePlacement.m is used, model file is Vehicle_Steering_sim_PolePlacement.slx. The controller is tuned using Ackermann's Formula by Pole-Placement. This is a very simple and straight forward approach to test the controller once developed.

<h3>Controller Tuning using LQR</h3>

Script file VehicleSteering_LQR.m is used, model file is VehicleSteering_sim_LQR.slx. The controller here is tuned using MATLAB"s in-built LQR function after the vehicle model is developed into a full-state system. In this case, it is assumed that all the states of the system can be measured directly and therefore, the controller design is porceeded forward using this approach. In later models, a Kalman- Filter will be developed that is used as a Soft-Sensor for measuring / observing the missing states required for a full state-feedback controller
