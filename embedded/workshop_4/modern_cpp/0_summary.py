# Python

class Motor_Type_1():
    def __init__(self, pin_pwm):
        self.pin_pwm = pin_pwm
    def forward(self, speed):
        pass # code to run this type of motor forward

class Motor_Type_2():
    def forward(self, speed):
        pass # code to run this type of motor forward

list_1 = [Motor_Type_1(2), Motor_Type_1(3)]
list_2 = [Motor_Type_2(), Motor_Type_2()]

def move_fwd(motors, speed):
    for m in motors:
        m.forward(speed)
    m_temp = Motor_Type_1(1);

# Python
if __name__ == '__main__':
    print("Hello world!")

    for i in range(4):
        list_1 += [Motor_Type_1(i)]
    del list_1[2]
    list_1.insert(1, Motor_Type_1(10))

    dict_1 = {"left": Motor_Type_1(2), 
              "right": Motor_Type_1(3)}
    dict_1["left"].pin_pwm = 1

    move_fwd(list_1, 100)
    move_fwd(list_2, 150)