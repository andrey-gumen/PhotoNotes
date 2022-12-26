import SwiftUI

struct DetailNoteView: View {
    @StateObject var viewModel: DetailNoteViewModel
    
    var body: some View {
        ZStack {
            // MARK: backgound block
            ZStack {
                let url = viewModel.note.imageUrl
                ColorScheme.detailBackground
                    .ignoresSafeArea(.all)
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    if url == nil {
                        ProgressView()
                    }
                }
                //Color.white
            }
            .ignoresSafeArea(.all)
            
            // MARK: note content block
            VStack {
                // date
                Text(viewModel.note.date.getFormattedDate("dd MMM YYYY"))
                    .font(.title)
                    .foregroundColor(.yellow)
                    .shadow(color: .black, radius: 3)
                    .blendMode(.luminosity)
                Divider()
                    .background(ColorScheme.detailForeground)
                    .shadow(color: .black, radius: 3)
                
                // note
                let fadeGap: CGFloat = 50
                ScrollView {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: fadeGap)
                    ZStack(alignment: .topLeading) {
                        TextEditorWithPlaceHolder(text: $viewModel.note.note)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(ColorScheme.detailForeground)
                            .shadow(color: .black, radius: 3)
                            .font(.title2.weight(.light))
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: fadeGap)
                }
                .verticalGradient(height: fadeGap)
                .padding(.horizontal)
                .padding(.top, -fadeGap)
                .padding(.bottom, -fadeGap)

                .padding(.leading, 6)
                
                // action block
                Button {
                    viewModel.outputs.deleteSubject.send(viewModel.note)
                } label: {
                    Image(systemName: "trash.fill")
                        .font(.title)
                        .tint(.red).opacity(0.7)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.size.width)
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.outputs.pickImageSubject.send()
                } label: {
                    Image(systemName: "camera.badge.ellipsis")
                }
            }
        }
        .tint(ColorScheme.tintForeground)
    }

}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            if let url = Bundle.main.url(forResource: "bobcat", withExtension: "jpg") {
                let note = PhotoNote(
                    date: Date.now,
                    imageUrl: url,
                    note: "На краю дороги стоял дуб. Вероятно, в десять раз старше берез, составлявших лес, он был в десять раз толще, и в два раза выше каждой березы. Это был огромный, в два обхвата дуб, с обломанными, давно, видно, суками и с обломанной корой, заросшей старыми болячками. С огромными своими неуклюже, несимметрично растопыренными корявыми руками и пальцами, он старым, сердитым и презрительным уродом стоял между улыбающимися березами. Только он один не хотел подчиняться обаянию весны и не хотел видеть ни весны, ни солнца.\n\n\"Весна, и любовь, и счастие! — как будто говорил этот дуб. — И как не надоест вам все один и тот же глупый бессмысленный обман! Все одно и то же, и все обман! Нет ни весны, ни солнца, ни счастья. Вон смотрите, сидят задавленные мертвые ели, всегда одинакие, и вон и я растопырил свои обломанные, ободранные пальцы, где ни выросли они — из спины, из боков. Как выросли — так и стою, и не верю вашим надеждам и обманам.\""
                )
                let viewModel = DetailNoteViewModel(PersistenceController.preview, note)
                DetailNoteView(viewModel: viewModel)
                    
            }
        }
    }
}
