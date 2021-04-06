
class FileManager(object):
    def start(self, fileOpen):
        self.fileDescr = fileOpen
        self.comparer = None
        self.jumpIndex = None
        self.command_type = None
        self.update()
        self.symbolIdnet = None
        self.destIdentifier = None

    def retrive(self):
        if self.curr_instruction[0] == '(':
            self.symbolIdnet = self.curr_instruction[1:-1]
            self.command_type = 'L_COMMAND'
        elif self.curr_instruction[0] == '@':
            self.symbolIdnet = self.curr_instruction[1:]
            self.command_type = 'A_COMMAND'
            self.instruction_num += 1
        else:
            self.command_type = 'C_COMMAND'
            splited = self.curr_instruction.split(';')
            self.destIdentifier = None
            self.comparer= None
            self.jumpIndex = None
            remainder = splited[0]
            if len(splited) == 2:
                self.jumpIndex = splited[1]
            splited = remainder.split('=')
            self.comparer = splited[0]
            if len(splited) == 2:
                self.destIdentifier = splited[0]
                self.comparer = splited[1]
            self.instruction_num += 1
        self.curr_instruction = (self.fileDescr.readline().strip().split('//')[0]).strip()

    @property
    def continueLopp(self):
        return  bool(self.curr_instruction)

    def update(self):
        self.fileDescr.seek(0)
        self.instruction_num = -1
        cur = self.fileDescr.readline().strip()
        while not cur or cur[:2] == '//':
            cur = self.fileDescr.readline().strip()
        self.curr_instruction = cur


if __name__ == '__main__':
    import sys
    fileName = sys.argv[1]
    ram_sz = 16
    symboles =   {
             'R0': '000000000000000',
             'R1': '000000000000001',
             'R2': '000000000000010',
             'R3': '000000000000011',
             'R4': '000000000000100',
             'R5': '000000000000101',
             'R6': '000000000000110',
             'R7': '000000000000111',
             'R8': '000000000001000',
             'R9': '000000000001001',
            'R10': '000000000001010',
            'R11': '000000000001011',
            'R12': '000000000001100',
            'R13': '000000000001101',
            'R14': '000000000001110',
            'R15': '000000000001111',
         'SCREEN': '100000000000000',
            'KBD': '110000000000000',
             'SP': '000000000000000',
            'LCL': '000000000000001',
            'ARG': '000000000000010',
           'THIS': '000000000000011',
           'THAT': '000000000000100',
        }
    jumpes = {
            'JGT': '001',
            'JEQ': '010',
            'JGE': '011',
            'JLT': '100',
            'JNE': '101',
            'JLE': '110',
            'JMP': '111',
        }
    comparees = {
              '0': '101010',
              '1': '111111',
             '-1': '111010',
              'D': '001100',
              'A': '110000',
             '!D': '001101',
             '!A': '110001',
             '-D': '001111',
             '-A': '110011',
            'D+1': '011111',
            'A+1': '110111',
            'D-1': '001110',
            'A-1': '110010',
            'D+A': '000010',
            'D-A': '010011',
            'A-D': '000111',
            'D&A': '000000',
            'D|A': '010101',
        }

    fileM = FileManager()
    fileOpen = open(fileName, 'r')
    fileM.start(fileOpen)
    hack_filename = fileName.replace('.asm', '.hack')
    hackFile = open(hack_filename, 'w')

    
    while fileM.continueLopp:
        fileM.retrive()
        if fileM.command_type == 'L_COMMAND':
            addressCom = '{0:b}'.format(int(fileM.instruction_num+1))
            szt = (15 - len(addressCom)) * '0'
            add = szt + addressCom
            symboles[fileM.symbolIdnet] = add

       
    fileM.update()
    while fileM.continueLopp:
        fileM.retrive()
        
        if fileM.command_type == 'C_COMMAND':
            nextLine = '111'
            bit = '0'
            if 'M' in fileM.comparer:
                bit = '1'
                fileM.comparer = fileM.comparer.replace('M', 'A')
            nextLine = nextLine + bit + comparees.get(fileM.comparer, '000000')
            strinde = fileM.destIdentifier
            desId = ['0', '0', '0']
            if strinde is None:
                nextLine += ''.join(desId)
            else:
                if 'M' in strinde:
                    desId[2] = '1'
                if 'D' in strinde:
                    desId[1] = '1'
                if 'A' in strinde:
                    desId[0] = '1'                   
                nextLine +=  ''.join(desId)
            nextLine += jumpes.get(fileM.jumpIndex, '000')
            hackFile.write(nextLine + '\n')
        
        
        if fileM.command_type == 'A_COMMAND':
            nextLine = '0'
            try:
                int(fileM.symbolIdnet)
                add = '{0:b}'.format(int(fileM.symbolIdnet))
                add =  ((15 - len(add)) * '0') + add
                nextLine += add
            except ValueError:
                if not fileM.symbolIdnet in symboles: 
                    add = '{0:b}'.format(int(ram_sz))
                    add =  ((15 - len(add)) * '0') + add
                    symboles[fileM.symbolIdnet] = add
                    ram_sz += 1
                nextLine += symboles[fileM.symbolIdnet]
            hackFile.write(nextLine + '\n')

    fileOpen.close()
    hackFile.close()

