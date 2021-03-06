# Autonomous-Vehile-Controls
Remote Git repository for Project "Autonomous vehicle controls".
Vehicle models and control algorithm are developed using Matlab / Simulink

## Running the simulation
The simulation models are all listed inside the Models folder and the corresponding scripts are linked to the simulink models, any changes in the simulation parameters canbe done directly using the individual script files associated to model files. For example, for the simulation of reference tracking contoller using LQR, find the model file models/VehicleSteering_sim_LQR.slx and the corresponding script file scripts/VehicleSteering_LQR.m


# Description of the project

Vehicle models are developed in the state-space form which makes it easier to develop controls using modern state-feedback controls. The following models are developed

## Active Suspension

Active suspension model descries the vertical dynamics of the vehicle which are thn used to develop a controller to damp the vibrations from the road.

## Power train model

The prower train model captures the transmission dynamics as well as the engine shaft and wheel speeds. Using this model the engine speed, wheel speed as well as the torsion in the transmission shaft can be controlled.

## Single track model

A linearised vehicle model is developed using a single track model. Following assumptions are considered
* Only plannar motion is considered along x, y directions as well the orientation angle about verticle axis, making a 3 DOF motion model
* all other motions along other co-odrinates are simply ignored as the focus here is to study only the lateral motion and orintation angle the vehicle model makes for the given inputs
* further longitudinal motion along x - direction is assumed constant in order to reduce the controlled states and avoiding a MIMO system. A MIMO system would be difficult to design with a PID controller. This is obviously not a problem for state-feedback based controllers such as LQR and MPC

### Model Inputs and Outputs
Modeled states are change in lateral position and change in rate of orientation angle (angular acceleration, important to be monitored for ensuring non-holonomic constraints), input is the steering angle and outputs are lateral position and orientation angle

# Controller Tuning using Pole Placement

Script file VehicleSteering_PolePlacement.m is used, model file is Vehicle_Steering_sim_PolePlacement.slx. The controller is tuned using Ackermann's Formula by Pole-Placement. This is a very simple and straight forward approach to test the controller once developed.

# Controller Tuning using LQR

Script file VehicleSteering_LQR.m is used, model file is VehicleSteering_sim_LQR.slx. The controller here is tuned using MATLAB"s in-built LQR function after the vehicle model is developed into a full-state system. In this case, it is assumed that all the states of the system can be measured directly and therefore, the controller design is porceeded forward using this approach. In later models, a Kalman- Filter will be developed that is used as a Soft-Sensor for measuring / observing the missing states required for a full state-feedback controller

# State Estimation

  A full state feedback controller requires a full set of states that can be measurable. This is not possible in most of the cases and hence, it is required that these missing states need to be derived using some technique. In this section, a Kalman - Filter is used for this purpose, where it is made possible to access the states without even measuring them. Starting from establishing the condition that observability is possible and that with a help of an observer a full system state can be determined either directly or in-directly.



  In this case a closed loop observer is designed, such that the observer is a copy of the original system which has the same inputs as the original system. The feedback to the obserer dynamics is added additionally to the controller inputs. The feedback signal is given by <MATH>L(y - y&#770)</MATH>. That is, the observer signal is compared with the original output and then feedback using an observer gain <MATH>L</MATH>. Such a closed loop design helps in adjusting the characteristic matrix <MATH>(A - LC)</MATH> with observer gain <MATH>L</MATH> so that the closed loop Eigenvalues of the observer can be stabalised.


# State estimation using Kalman - Bucy Filter


  The most effective estimation of system states required for a full state feedback controller are determined using a cost function that is minimised through varying the observer gain <MATH>L</MATH>. The cost function here is a covariance of measurement noise and process disturbances that minimises a covariance matrix <MATH>P<sub>x&#771;</sub></MATH>. The solution to the covariance matrix is given by solving the Riccati's equation, where <MATH>P<sub>x&#771;</sub></MATH> is a matrix of size <MATH>(n x n)</sub></MATH>, <MATH>n</sub></MATH> being the number of system states.



  Kalman - Bucy discovered that when the system is observable, the optimal observer gain matrix L is given by <MATH>L = P<sub>x&#771;</sub> C<sup>T</sup> R<sup>-1</sup><sub>w</sub> </MATH>. This optimal observer gain is used in this project that has the following properties

   - always stable
   - the optimal linear filter for state estimation
   - <MATH>R<sub>v</sub></MATH> and <MATH>R<sub>w</sub></MATH> are regarded as the design parameters

There are similarities between Kalman Filter and LQR, in-fact, using them both in the controller design **_linear quadratic Gaussian controller_**.

# Autonomous Lane changing controller

  Using the single track vehicle model developed earlier, a lane automated lane changing maneuver controller is developed which over takes a preceeding vehicle within 2 seconds which is a movement of 3.5m. The system states include the lateral velocity and the yaw-rate of the vehicle. The longitudinal velocity is maintained a constant. Control input is the steering rate and lateral position of the vehicle is measured as the output. In order to model the actuator for this autonomous lane changing maneuver, a non-linear steering actuator is considered which is then linearised about an operating point that makes zero angle towards the heading direction. The steering actuator changes the steering rate. Furthermore, the vehicles real world position and heading angle are included into the state-space model, this is done mainly for control purposes.

### Updated system states
The updated system model now includes the following states

* lateral position in global frame
* lateral velocity in vehicle frame
* orientation angle
* yaw-rate
* steering angle

## Designing MPC Controller

### Reduced State-Space model

A new reduced state-space model is implemented where the non-linear steering dynamics from the actuator are removed and instead assumed that control is directly applied on the steering angle (delta). The reduced state-space is now:
* lateral position in Global Frame
* lateral velocity in Body Frame
* orientation angle
* yaw-rate

**The input of the system**:
* steering angle (delta) - for which the system is completely controllable

**System Outputs**:
* lateral poistion and
* orientation angle - for which the system is completely observable

**Reference**:
* The reference signals generated are for both the lateral position and orientation angle. In MPC block the dimensions of measured outputs should match the dimensions of reference signals, in fact they have to be the same signals

**MPC Block Settings**
* Prediction Horizon: 10 steps
* Control Horizon: 3 steps
* Constraints:
  * input constraints on steeering angle: pi/6 rad, steering rate: pi/12 rad/s
  * output constraints:
    * lateral motion: -2 to 6 m
    * orientiation angle: -0.2 to +0.2
* Weights:
  * weights on inputs:
    * steeering angle: 0 (it is not important variable for achieving lane changing maneuver)
  * weights on outputs:
    * lateral motion: 1.0 (most important variable for achieving lane changing maneuver)
    * orientiation angle: 0.1
