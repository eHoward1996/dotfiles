import sys

def main():
    print(' '.join(sorted(set(sys.argv[1:]))).upper())


if __name__ == '__main__':
    main()
