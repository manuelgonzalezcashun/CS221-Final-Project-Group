#Test file to get the code section started
#Ellmaer 
#Manny
#Alex
#Nik

class Main(user_input): 
  def __init__(self, user_input):
    self.user_input = user_input
    
  def print_input(self):
    print(self.user_input)
    
    
def main():
  user_input = input("Enter Something: ")
  object = Main(user_input)
  object.print_input()
  
  
main()
