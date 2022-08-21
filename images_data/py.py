# import os

# counter=0

# archives =[]

# for fileName in os.listdir(os.getcwd()):
#     if(fileName.find(".data")!=-1):
#         firstFileLine = open(fileName).readlines()[0].rstrip()
#         strings = firstFileLine.split()
#         strings[2]=strings[2][:-1]
#         thisFileSize =  int(strings[2])*int(strings[3])
#         counter += thisFileSize
#         print(f"{strings[0][:-1]}: {thisFileSize} bytes")
#         archives.append((thisFileSize,strings[0][:-1]))
# print(f"\nOcupação total da memória de dados(em bytes): {counter}")
# print(f'Tamanho da memória de dados(em bytes){160*pow(2,10)}')        

# archives.sort()

# for i in archives:
#     print(i[1])

