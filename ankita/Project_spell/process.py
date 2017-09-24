#/usr/bin/python


from libs.constants import TRAINING_PATH, TRAINING_FILENAME
import numpy as np
import pandas as pd
import os

def main():
    filename =  os.path.join(TRAINING_PATH, TRAINING_FILENAME)
    data = pd.read_csv(filename, header=None, names=['name1','name2','class'])

if __name__ == "__main__":
    main()