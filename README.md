# Formation-control-using-consensus-problems

## Consensus Problem

Consensus problems involve designing protocols that allow a group of agents to agree on certain quantities of interest. These algorithms are crucial in applications such as coordination of autonomous vehicles, sensor networks, and distributed computing.

### Overview

#### *What is Consensus?*

In the context of multi-agent systems, consensus refers to the process by which a network of agents (nodes) reach an agreement on a particular state or quantity. The goal is to ensure that all agents eventually converge to a common value, despite differences in their initial states.

#### *Mathematical Formulation*

The consensus problem can be mathematically represented by the differential equation:

$$\frac{dx}{dt} = -Lx$$

where:
- $x$ is the state vector representing the value held by each agent.
- $L$ is the Laplacian matrix of the graph representing the network of agents.

The Laplacian matrix $L$ captures the connectivity of the network and the interaction weights between agents.

#### *Key Concepts*

- **Laplacian Matrix:** It is defined as $L = D - A$, where $D$ is the degree matrix and $A$ is the adjacency matrix of the graph.
- **Convergence:** The process by which the state values of all agents approach a common value over time.
- **Directed and Undirected Graphs:** The type of graph (directed or undirected) affects the properties of the Laplacian matrix and, consequently, the behavior of the consensus algorithm.

## Codes

- ***formation_control_preview.m:*** This is the main code. Formation control is performed using consensus problems. The formation transforms in the order of stars, hearts, and butterflies.
- ***formation_control_compare.m:*** Visualize the difference in formation formation speed and retention due to the sparsity of the graph.
  
- ***formation_control.m*** Please use it when you make a formation with your favorite image.
- ***ImagetoCoordinate.m:*** Converts image data to xy point cloud data. Use this function when you form a formation using your favorite image.

*If you use your favorite image, generate a csv file with *ImagetoCoordinate.m* and then run *formation_control.m*.



## Reference
Reza Olfati-Saber, J. Alex Fax, Richard M. Murray, “Consensus and Cooperation in Networked Multi-Agent Systems,” Proceedings of the IEEE, vol. 95, pp. 215–233, 2007.
