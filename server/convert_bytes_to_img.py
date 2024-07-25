import re
outputImg = open("img.jpg", 'wb')

with open("img.txt") as f:
    input = f.read()
    imgBytes = re.split(r'\n|,', input)

print(imgBytes)

for imgByte in imgBytes:
    if len(imgByte) > 0:
        outputImg.write((int(imgByte, 16)).to_bytes(1, "little"))
outputImg.close()