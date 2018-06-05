# Load the package
library(ReinforcementLearning)

# Here we define our "Race-to-Goal" environment
RACE.env <- function(state, action) {
  next_state <- state
  ## define all possible state-action-next state triples
## There is no need to define action movements out of state s0
  ## or out of state s1 as those are end (or absorbing) states.
  if(state == state("s3") && action == "left") next_state <- state("s2")
  if(state == state("s3") && action == "up") next_state <- state("s7")
  ## Note: no need to define being in s0 and choosing action
  ## to move left as the next_state would still be s0.
  ## You only need to define possible movements to a new state.
  if(state == state("s2") && action == "left") next_state <- state("s1")
  if(state == state("s2") && action == "up") next_state <- state("s6")
  if(state == state("s4") && action == "up") next_state <- state("s8")
  if(state == state("s4") && action == "down") next_state <- state("s0")
  if(state == state("s5") && action == "left") next_state <- state("s4")
  if(state == state("s5") && action == "up") next_state <- state("s9")
  if(state == state("s5") && action == "down") next_state <- state("s1")
 ##For s6 there is no left since it has red wall
  if(state == state("s6") && action == "up") next_state <- state("s10")
  if(state == state("s6") && action == "down") next_state <- state("s2")
  if(state == state("s7") && action == "left") next_state <- state("s6")
  if(state == state("s7") && action == "up") next_state <- state("s11")
  if(state == state("s7") && action == "down") next_state <- state("s3")
  if(state == state("s8") && action == "up") next_state <- state("s12")
  if(state == state("s8") && action == "down") next_state <- state("s4")
  if(state == state("s9") && action == "up") next_state <- state("s13")
  if(state == state("s9") && action == "down") next_state <- state("s5")
  if(state == state("s10") && action == "up") next_state <- state("s14")
  if(state == state("s10") && action == "down") next_state <- state("s6")
  if(state == state("s11") && action == "left") next_state <- state("s10")
  if(state == state("s11") && action == "up") next_state <- state("s15")
  if(state == state("s11") && action == "down") next_state <- state("s7")
  if(state == state("s12") && action == "up") next_state <- state("s16")
  if(state == state("s12") && action == "down") next_state <- state("s8")
  if(state == state("s13") && action == "up") next_state <- state("s17")
  if(state == state("s13") && action == "down") next_state <- state("s9")
  if(state == state("s14") && action == "up") next_state <- state("s18")
  if(state == state("s14") && action == "down") next_state <- state("s10")
  if(state == state("s15") && action == "left") next_state <- state("s14")
  if(state == state("s15") && action == "up") next_state <- state("s19")
  if(state == state("s15") && action == "down") next_state <- state("s11")
  if(state == state("s16") && action == "down") next_state <- state("s12")
  if(state == state("s17") && action == "down") next_state <- state("s13")
  if(state == state("s18") && action == "left") next_state <- state("s17")
  if(state == state("s18") && action == "down") next_state <- state("s14")
  if(state == state("s19") && action == "left") next_state <- state("s18")
  if(state == state("s19") && action == "down") next_state <- state("s15")
  
  
  ## define rewards in each state
  ## make them all 0 initially:
  reward <- 0
  ## Then define the exceptions: Entering
  ## Goal state s0 has reward of +10;
  ## there is only one way to enter s0
  ## from s4:
  if (next_state == state("s0") && (state == state("s4"))) reward <- 10
  ## Negative Reward End state s1 has reward of -10.
  ## Can enter state s1 from  from s5, and from s2
  if (next_state == state("s1") && (state == state("s5"))) reward <- -10
  if (next_state == state("s1") && (state == state("s2"))) reward <- -10
  
  ## Function returns a list of next_state and reward
  out <- list("NextState" = next_state, "Reward" = reward)
  return(out)
}

# Define state and action sets
states <- c("s0", "s1", "s2", "s3", "s4",
            "s4", "s5", "s6", "s7", "s8",
            "s9", "s10", "s11", "s12", "s13",
            "s14", "s15", "s16", "s17", "s18", "s19")
states # twenty states
actions <- c("up", "down", "left")
actions # three actions

# Sample N = 1000 random sequences from the
# Race-to-Goal environment function above.
# Data format must be (s,a,r,s_new) tuples,
# each as rows in a dataframe structure.

# Set seed for replicability
set.seed(1234)
# ?sampleExperience
data <- sampleExperience(N = 1000, 
                         env = RACE.env, 
                         states = states, 
                         actions = actions)

# Show first 250 records of data
data

## Performing Reinforcement Learning

# Define reinforcement learning parameters
control <- list(alpha = 0.1, # low learning rate
                gamma = 0.5, # middle discount factor
                # epsilon only relevant when sampling
                # new experience based on known rewards
                epsilon = 0.1) # low exploration factor
control

# Perform reinforcement learning
# ?ReinforcementLearning
RACE.model <- ReinforcementLearning(data, 
                                    s = "State", 
                                    a = "Action", 
                                    r = "Reward", 
                                    s_new = "NextState",
                                    actionSelection = "random",
                                    control = control)

# Print result
print(RACE.model)
summary(RACE.model)

set.seed(1234)
# ?sampleExperience
data_new <- sampleExperience(N = 1000, 
                             # use same environment
                             env = RACE.env, 
                             states = states, 
                             actions = actions, 
                             # note we are using the
                             # existing model from before
                             model = RACE.model, 
                             actionSelection = "epsilon-greedy", 
                             control = control)

# Show first 250 records of data
data_new

## Performing Reinforcement Learning

# Define reinforcement learning parameters
control <- list(alpha = 0.1, # low learning rate
                gamma = 0.5, # middle discount factor
                # epsilon only relevant when sampling
                # new experience based on known rewards
                epsilon = 0.1) # low exploration factor
control

# Perform reinforcement learning
# ?ReinforcementLearning
RACE.model_new <- ReinforcementLearning(data_new, 
                                   s = "State", 
                                   a = "Action", 
                                   r = "Reward", 
                                   s_new = "NextState", 
                                   control = control,
                                   model = RACE.model)

# Print result
print(RACE.model_new)
summary(RACE.model_new)
plot(RACE.model_new)




# Set seed for replicability
set.seed(1234)
# ?sampleExperience
data_5000 <- sampleExperience(N = 5000, 
                         env = RACE.env, 
                         states = states, 
                         actions = actions)

# Show first 250 records of data
data_5000

## Performing Reinforcement Learning

# Define reinforcement learning parameters
control <- list(alpha = 0.1, # low learning rate
                gamma = 0.5, # middle discount factor
                # epsilon only relevant when sampling
                # new experience based on known rewards
                epsilon = 0.1) # low exploration factor
control

# Perform reinforcement learning
# ?ReinforcementLearning
RACE.model_5000 <- ReinforcementLearning(data_5000, 
                                    s = "State", 
                                    a = "Action", 
                                    r = "Reward", 
                                    s_new = "NextState",
                                    actionSelection = "random",
                                    control = control)

# Print result
print(RACE.model_5000)
summary(RACE.model_5000)
plot(RACE.model_5000)


# Set seed for replicability
set.seed(1234)
# ?sampleExperience
data_10000 <- sampleExperience(N = 10000, 
                         env = RACE.env, 
                         states = states, 
                         actions = actions)

# Show first 250 records of data
data_10000

## Performing Reinforcement Learning

# Define reinforcement learning parameters
control <- list(alpha = 0.1, # low learning rate
                gamma = 0.5, # middle discount factor
                # epsilon only relevant when sampling
                # new experience based on known rewards
                epsilon = 0.1) # low exploration factor
control

# Perform reinforcement learning
# ?ReinforcementLearning
RACE.model_10000 <- ReinforcementLearning(data_10000, 
                                    s = "State", 
                                    a = "Action", 
                                    r = "Reward", 
                                    s_new = "NextState",
                                    actionSelection = "random",
                                    control = control)

# Print result
print(RACE.model_10000)
summary(RACE.model_10000)
plot(RACE.model_10000)


