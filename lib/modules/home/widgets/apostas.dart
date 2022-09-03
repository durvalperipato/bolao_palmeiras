part of '../home_page.dart';

class Apostas extends StatefulWidget {
  final List<ApostaModel> apostas;
  const Apostas({Key? key, required this.apostas}) : super(key: key);

  @override
  State<Apostas> createState() => _ApostasState();
}

class _ApostasState extends State<Apostas> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          height: 1,
          color: Colors.grey,
        ),
        itemCount: widget.apostas.length,
        itemBuilder: (context, index) {
          List<String> name = widget.apostas.elementAt(index).user.split(' ');
          String? firstName = name.first;
          String? lastName = name.last;
          return ListTile(
            title: Text(firstName),
            subtitle: Text(lastName),
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage(widget.apostas.elementAt(index).avatarURL ?? ''),
            ),
            trailing: SizedBox(
              width: 160,
              child: Row(
                children: [
                  SizedBox(
                      width: 70,
                      child: Center(
                          child: Text(widget.apostas.elementAt(index).placarMandante.toString()))),
                  const SizedBox(width: 16, child: Center(child: Text('x'))),
                  SizedBox(
                    width: 70,
                    child: Center(
                      child: Text(
                        widget.apostas.elementAt(index).placarVisitante.toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
