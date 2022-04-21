class pivot:
    
    def __init__(self,**KW):
        self.data = { 'matrix' : {} , 'x' : [], 'y' : [] }
        self.stats = {}
        self.pvt = { 'x' : {}, 'y' : {}}

    def plot(self,x,y,z,c = 'neutral'):
        if not x in self.data['x']:
            self.data['x'].append(x)
        if not y in self.data['y']:
            self.data['y'].append(y)
        if not x in self.data['matrix']:
            self.data['matrix'][x] = {}
        
        self.data['matrix'][x][y] = { 
            'content'       : z,
            'class'         : c
        }
    def display(self):
        out = '<table border=1>\n'

        # -- build the header
        out += '   <tr>\n      <th>&nbsp;</th>\n'
        for y in sorted(self.data['y']):
            out += f'      <th>{y}</th>\n'
        out += '   </tr>'
        for x in sorted(self.data['x']):
            out += f'   <tr>\n      <th>{x}</th>\n'

            for y in sorted(self.data['y']):
                z = self.data['matrix'].get(x,{}).get(y,None)

                if z == None:
                    v = '&nbsp;'
                    c = 'neutral'
                else:
                    v = z['content']
                    c = z['class']

                out += f'      <td class="{c}">{v}</td>\n'

            out += '   </tr>\n'

        out += '</table>\n'

        return out

if __name__ == '__main__':
    
    with open('c:/temp/test.html','wt') as h:
        h.write('<html>')

        h.write('<h1>Basic matrix usage</h1>')

        pvt = pivot()
        pvt.plot('Australia','Wallaby','Yes','red')
        pvt.plot('South Africa','Springbok','Yes')
        h.write(pvt.display())
