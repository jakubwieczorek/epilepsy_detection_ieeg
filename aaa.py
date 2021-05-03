train_dirs = ["../dataset/ID08/64/train_data18/",
              "../dataset/ID08/64/train_data20/",
              "../dataset/ID08/64/train_data21/"]

train_files = []
for diR in train_dirs:
    [train_files.append(diR + file) for file in os.listdir(diR)]