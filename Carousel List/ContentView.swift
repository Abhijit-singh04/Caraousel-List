
import SwiftUI

struct ContentView: View {
    var body: some View {
           
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var op : CGFloat = 0
    
    @State var data = [

        Card(id: 0, img: "p1", name: "Sourjya Bhaumik", show: false),
        Card(id: 1, img: "p2", name: "Ashish Rathore", show: false),
        Card(id: 2, img: "p3", name: "Vivek Vekariya", show: false),
        Card(id: 3, img: "p4", name: "Aditya Sinha", show: false),
        Card(id: 4, img: "p5", name: "Abhijit Singh", show: false),
//        Card(id: 5, img: "p6", name: "A K R", show: false),
//        Card(id: 6, img: "p7", name: "A R", show: false),
//        Card(id: 7, img: "p7", name: "V V 2", show: false)
        


    ]
    
    var body : some View{
        
        NavigationView{
            
            VStack{
                
                Spacer()
                
                HStack(spacing : 20){
                    
                    ForEach(data){i in

                        CardView(data: i)
                        .offset(x: self.x)
                        .highPriorityGesture(
                            DragGesture()

                            .onChanged({ (value) in
//                                onChanged is a callback that is called when the user starts to drag the card. I
                                if value.translation.width > 0{

                                    self.x = value.location.x
                                }
                                else{

                                    self.x = value.location.x - self.screen
                                }

                            })
//                            onEnded is a callback that is called when the user stops dragging the card. I
                            .onEnded({ (value) in

                                if value.translation.width > 0{


                                    if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{


                                        self.count -= 1
                                        self.updateHeight(value: Int(self.count))
                                        self.x = -((self.screen + 15) * self.count)
                                    }
                                    else{

                                        self.x = -((self.screen + 15) * self.count)
//                                        ((self.screen + 15) * self.count) calculates the total distance that the cards should be shifted based on the current index of the card, and self.x is set to the negative of this distance, which causes the cards to move left or right based on the direction of the swipe.
                                    }
                                }
                                else{


                                    if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.data.count - 1){

                                        self.count += 1
                                        self.updateHeight(value: Int(self.count))
                                        self.x = -((self.screen + 15) * self.count)
                                    }
                                    else{

                                        self.x = -((self.screen + 15) * self.count)
                                    }
                                }
                            })
                        )
                        .background(Color.green)

                    }
                }
                .frame(width: UIScreen.main.bounds.width)
//                applied to inside view of hstack
                .offset(x: self.op)
                .background(Color.yellow)
                .padding()
                
                Spacer()
            }
//            .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.bottom))
            .background(Color.red)
            .animation(.spring())
            .onAppear {
                
                self.op = ((self.screen + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 15) / 2) : 0)
                
                self.data[0].show = true
                print("self.op ->", self.op)
                print("self.screen ->", self.screen)
                print("self.screen ->", self.screen)
                print("self.data.count->", self.data.count)
                print("self.data.count/2 ->", self.data.count / 2)
                print("CGFloat(self.data.count / 2) ->", CGFloat(self.data.count / 2))
                print("self.data.count%2 ->", self.data.count % 2)
                
            }
        }
    }
    
    func updateHeight(value : Int){
        
        
//        for i in 0..<data.count{
//
//            data[i].show = false
//        }
        
        data[value].show = true
    }
}

struct CardView : View {
    
    var data : Card
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 0){
            
//            Image(data.img)
//            .resizable()
            
            Text(data.name)
                .fontWeight(.bold)
                .padding(.vertical, 13)
                .padding(.leading)
            
        }
        .frame(width: UIScreen.main.bounds.width - 30, height: data.show ? 500 : 440)
        .background(Color.gray)
//        .padding()
//        .cornerRadius(25)
    }
}

struct Card : Identifiable {
    
    var id : Int
    var img : String
    var name : String
    var show : Bool
}



