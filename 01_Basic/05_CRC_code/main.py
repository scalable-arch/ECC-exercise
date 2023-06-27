import numpy as np
from crc import * 

def main():
    np.random.seed(0)
    
    gen = np.array([1,1,0,1,0,1]) ## x^5 + x^4 + x^2 + 1
    # gen = np.array([1,1,1,0,1,0,1,0,1]) ## x^8+x^7+x^6+x^4+x^2+1
    
    ## Print the generator polynomial in array form
    print(f"Test the generator polynomial {gen}")
    
    ## Get period
    period = get_period(gen)
    print(f"Period is {period}")

    ## Do monte carlo simulation
    monte_carlo_sim(gen, 10, 2000000)

if __name__ == '__main__':
    main()
