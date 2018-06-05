
# Load the package
library(ReinforcementLearning)

# Define your modified  "Race-to-Goal" environment
RACE.env <- function(state, action) {
  next_state <- state
  ## define all possible state-action-next state triples
  
  # <Your modified code goes here>
  
  ## define rewards in each state
  ## make them all 0 initially:
  reward <- 0
  ## Then define the exceptions: Entering
  ## Goal state s0 has reward of +10:
  
  # <Your modified code goes here>
  
  ## Negative Reward End State s1 has reward of -10.
  
  # <Your modified code goes here>  
  
  ## Function returns a list of next_state and reward
  out <- list("NextState" = next_state, "Reward" = reward)
  return(out)
}

# Define state and action sets

# <Your modified code for 20 states goes here>  

# <Your modified code for the 3 actions goes here>  

# Sample N = 1000 (originally) random sequences from the
# Race-to-Goal environment function above.
# Data format must be (s,a,r,s_new) tuples,
# each as rows in a dataframe structure.

# Set seed for replicability
set.seed(1234)
data <- # <Your code for goes here>  
  # Use the sampleExperience() function
  
  # Show first 250 records of data
  data

## Perform Reinforcement Learning

# Define reinforcement learning parameters
# Use same parameters unchanged
control <- list(alpha = 0.1, # low learning rate
                gamma = 0.5, # middle discount factor
                # epsilon only relevant when sampling
                # new experience based on known rewards
                epsilon = 0.1) # low exploration factor

# Perform reinforcement learning
RACE.model <- # <Your code for goes here>  
  # Use the ReinforcementLearning() function
  
  # Print result
  print(RACE.model)
