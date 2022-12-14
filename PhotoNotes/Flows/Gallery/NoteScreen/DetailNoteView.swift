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
                    viewModel.inputs.deleteSubject.send()
                } label: {
                    Image(systemName: "trash.fill")
                        .font(.title)
                        .tint(.red).opacity(0.7)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.size.width)
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.inputs.saveNoteSubject.send()
                } label: {
                    Text("Save")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.inputs.pickImageSubject.send()
                } label: {
                    Image(systemName: "camera.badge.ellipsis")
                }
            }
        }
    }

}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            if let url = Bundle.main.url(forResource: "bobcat", withExtension: "jpg") {
                let note = PhotoNote(
                    date: Date.now,
                    imageUrl: url,
                    note: "???? ???????? ???????????? ?????????? ??????. ????????????????, ?? ???????????? ?????? ???????????? ??????????, ???????????????????????? ??????, ???? ?????? ?? ???????????? ?????? ??????????, ?? ?? ?????? ???????? ???????? ???????????? ????????????. ?????? ?????? ????????????????, ?? ?????? ?????????????? ??????, ?? ??????????????????????, ??????????, ??????????, ???????????? ?? ?? ???????????????????? ??????????, ???????????????? ?????????????? ??????????????????. ?? ?????????????????? ???????????? ????????????????, ?????????????????????????? ???????????????????????????? ???????????????? ???????????? ?? ????????????????, ???? ????????????, ???????????????? ?? ?????????????????????????? ???????????? ?????????? ?????????? ???????????????????????? ????????????????. ???????????? ???? ???????? ???? ?????????? ?????????????????????? ?????????????? ?????????? ?? ???? ?????????? ???????????? ???? ??????????, ???? ????????????.\n\n\"??????????, ?? ????????????, ?? ??????????????! ??? ?????? ?????????? ?????????????? ???????? ??????. ??? ?? ?????? ???? ?????????????? ?????? ?????? ???????? ?? ?????? ???? ???????????? ?????????????????????????? ??????????! ?????? ???????? ?? ???? ????, ?? ?????? ??????????! ?????? ???? ??????????, ???? ????????????, ???? ??????????????. ?????? ????????????????, ?????????? ?????????????????????? ?????????????? ??????, ???????????? ????????????????, ?? ?????? ?? ?? ???????????????????? ???????? ????????????????????, ???????????????????? ????????????, ?????? ???? ?????????????? ?????? ??? ???? ??????????, ???? ??????????. ?????? ?????????????? ??? ?????? ?? ????????, ?? ???? ???????? ?????????? ???????????????? ?? ??????????????.\""
                )
                let viewModel = DetailNoteViewModel(PersistenceController.preview, note)
                DetailNoteView(viewModel: viewModel)
                    
            }
        }
    }
}
