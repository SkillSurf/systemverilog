import numpy as np
import serial

R=8
C=8

for i in range(20):
  print(f"****************** TEST {i+1} ************************\n\n")

  k = np.random.randint(low=-2**7, high=2**7, size=(R,C), dtype=np.int8)
  x = np.random.randint(low=-2**7, high=2**7, size=(C), dtype=np.int8)
  y_exp = k.astype(np.int32) @ x.astype(np.int32)

  '''
  Send k & x
  '''
  kx = np.concatenate([x, k.flatten()])
  kx_bytes = kx.tobytes()

  print(f"\n\n {k=} \n\n{x=} \n\n{kx=} \n\nSent: {kx_bytes= } \n\n")


  '''
  Receive y
  '''
  y_bytes = 
  y = np.frombuffer(y_bytes, dtype=np.int32)

  print(f"Received: \n\n{y=} \n\n {y_exp=} \n\n\n")

  assert (y == y_exp).all(), f"Output doesn't match: y:{y} != y_exp:{y_exp}"