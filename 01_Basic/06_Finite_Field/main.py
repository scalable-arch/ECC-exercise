'''
ECC 3rd homework
Author : PTW
Date : 22.07.04
'''

from finitefield import FiniteField

if __name__ == '__main__':
    f = FiniteField(4,19)

    if f.success:
        f.printField()
        print('Add result is', f.add(3,5))
        print('Sub result is', f.sub(6,3))
        print('Mul result is', f.mul(2,8))
        print('Mul result is', f.mul(0,4))
        print('Div result is', f.div(2,3))

        print('Add result is ', f.add(3,16))
        print('Sub result is ', f.sub(-1,2))
        print('Mul result is ', f.mul(-1,55))
        print('Div result is ', f.div(5,0))

    f = FiniteField(8,285)

    if f.success:
        f.printField()
        print('Add result is', f.add(31,55))
        print('Sub result is', f.sub(62,37))
        print('Mul result is', f.mul(255,85))
        print('Mul result is', f.mul(90,254))
        print('Div result is', f.div(35,135))

        print('Add result is ', f.add(256,23))
        print('Sub result is ', f.sub(-1,30))
        print('Mul result is ', f.mul(-1,55))
        print('Div result is ', f.div(52,0))
