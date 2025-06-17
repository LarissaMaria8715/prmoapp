import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HabitosPage extends StatefulWidget {
 @override
 _HabitosPageState createState() => _HabitosPageState();
}

class _HabitosPageState extends State<HabitosPage> {
 double aguaLitros = 0.0;
 double horasSono = 0.0;

 Widget CalculoHoras(){
   if(horasSono == 8){
     return SizedBox(height: 32, child: Text('Ótimo! Está indo bem!'));
   } else if(horasSono == 7){
     return SizedBox(height: 32, child: Text('Está indo bem!'));
   } else if(horasSono == 6){
     return SizedBox(height: 32, child:Text('Pode dar uma melhorada!'));
   } else if(horasSono == 5){
 return SizedBox(height: 32, child: Text('Ruim, precisa melhorar!'));
   } else if(horasSono == 4){
     return SizedBox(height: 32, child: Text('Muito ruim, precisa melhorar!'));
   } else if(horasSono == 3){
     return SizedBox(height: 32, child: Text('Horrivél, precisa melhorar com urgência!'));
   } else if(horasSono == 2){
     return SizedBox(height: 32, child: Text('Horrivél, precisa melhorar com urgência!'));
   } else if(horasSono == 1){
     return SizedBox(height: 32, child: Text('Horrivél, precisa melhorar com urgência!'));
   } else if(horasSono == 9){
     return SizedBox(height: 32, child: Text('Bom! Está no limite'));
   } else if(horasSono == 10){
     return SizedBox(height: 32, child: Text('Ruim! Pode diminuir um pouco!'));
   } else if(horasSono == 11){
     return SizedBox(height: 32, child: Text('Ruim! Está exagerando'));
   } else if(horasSono == 12){
     return SizedBox(height: 32, child: Text('Horrivél! Não precisa tanto!'));
   } else if(horasSono == 13){
     return SizedBox(height: 32, child: Text('Exagero! Não precisa de tudo isso!'));
   } else if(horasSono == 14){
     return SizedBox(height: 32, child: Text('Muito exagerado! Sem ncessidade'));
   } else if(horasSono >= 15){
     return SizedBox(height: 32, child: Text('Horrivél, muito exagerado e sem necessidade!'));
   }
   return SizedBox(height: 32);
 }


 Widget CalculoAgua(){
   if(aguaLitros == 3){
     return SizedBox(height: 32, child: Text('Ótimo! Você está tomando bastante água!'));
   } else if(aguaLitros == 2.5){
     return SizedBox(height: 32, child: Text('Está indo bem! Pode beber mais um pouquinho'));
   } else if(aguaLitros == 2.0){
     return SizedBox(height: 32, child: Text('Pode dar uma melhorada!'));
   } else if(aguaLitros == 1.5){
     return SizedBox(height: 32, child: Text('Precisa melhorar!'));
   } else if(aguaLitros == 1){
     return SizedBox(height: 32, child: Text('Muito ruim, precisa melhorar!'));
   } else if(aguaLitros == 0.5){
     return SizedBox(height: 32, child: Text('Horrivél, precisa melhorar com urgência!'));
   }
   return SizedBox(height: 32);
 }


 @override
 Widget build(BuildContext context) {
   double progressoAgua = aguaLitros / 3.0; // meta: 3 litros
   double progressoSono = horasSono / 8.0;  // meta: 8 horas


   return Scaffold(
     appBar: AppBar(
       title: Text('Hábitos Diários'),
       backgroundColor: AppColors.Purple,
       leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: AppColors.white),
         onPressed: () {
           // Navegação futura
         },
       ),
     ),
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: ListView(
         children: [Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('Meta de Água (litros)', style: TextStyle(fontSize: 18)),
               Slider(
                 value: aguaLitros,
                 min: 0,
                 max: 3,
                 divisions: 6,
                 label: '${aguaLitros.toStringAsFixed(1)} L',
                 onChanged: (valor) {
                   setState(() {
                     aguaLitros = valor;
                   });
                 },
               ),


               CalculoAgua(),


               Text('Meta de Sono (horas)', style: TextStyle(fontSize: 18)),

               Slider(
                 value: horasSono,
                 min: 0,
                 max: 15,
                 divisions: 15,
                 label: '${horasSono.toStringAsFixed(1)} h',
                 onChanged: (valor) {
                   setState(() {
                     horasSono = valor;
                   });
                 },
               ),


               CalculoHoras(),


               TextFormField(
                 decoration: InputDecoration(
                   labelText: 'Observação'
                 ),
               ),

               SizedBox(height: 250)
             ],
           ),
       ]
       ),
     ),


   );


 }
}
