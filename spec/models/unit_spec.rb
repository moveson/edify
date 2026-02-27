require "rails_helper"

describe ::Unit do
  describe "#next_available_sunday" do
    let(:unit) { units(:sunny_hills) }

    let(:result) { unit.next_available_sunday }
    before { travel_to(test_date) }

    context "when the upcoming Sunday does not have a meeting scheduled" do
      let(:test_date) { "2022-05-02" }

      it "returns the upcoming Sunday" do
        expect(result).to eq("2022-05-08".to_date)
      end

      context "when there is a meeting scheduled on the upcoming Saturday" do
        before { unit.meetings.create!(date: "2022-05-07", meeting_type: :stake_conference) }

        it "returns the upcoming Sunday" do
          expect(result).to eq("2022-05-08".to_date)
        end
      end
    end

    context "when the upcoming Sunday has a meeting scheduled but the next does not" do
      let(:test_date) { "2022-04-30" }

      it "returns the first available Sunday" do
        expect(result).to eq("2022-05-08".to_date)
      end
    end

    context "when several upcoming Sundays have meetings scheduled" do
      let(:test_date) { "2022-03-25" }

      it "returns the first available Sunday" do
        expect(result).to eq("2022-05-08".to_date)
      end
    end

    context "when there are no meetings scheduled in the future" do
      let(:test_date) { "2022-05-16" }

      it "returns the first available Sunday" do
        expect(result).to eq("2022-05-22".to_date)
      end
    end
  end

  describe "#song_last_sung" do
    let(:unit) { units(:sunny_hills) }
    let(:result) { unit.song_last_sung(title, date) }
    let(:title) { "Away in a Manger #206" }
    let(:date) { "2022-04-10".to_date }

    context "when the song was sung previously" do
      context "when sung as an opening song" do
        it { expect(result).to eq(songs(:song_1)) }
      end

      context "when played as a prelude song" do
        before { songs(:song_1).update(song_type: :prelude) }

        it { expect(result).to be_nil }
      end
    end

    context "when the song was sung after but not previously" do
      let(:date) { "2022-03-03".to_date }
      it { expect(result).to be_nil }
    end

    context "when the song was never sung" do
      let(:title) { "Not a real song" }
      it { expect(result).to be_nil }
    end

    context "when title is blank" do
      let(:title) { "" }
      it { expect(result).to be_nil }
    end

    context "when title is nil" do
      let(:title) { nil }
      it { expect(result).to be_nil }
    end

    context "when date is nil" do
      let(:date) { nil }
      it { expect(result).to be_nil }
    end
  end

  describe "#speaker_last_talk" do
    let(:unit) { units(:sunny_hills) }
    let(:result) { unit.speaker_last_talk(name, date) }
    let(:name) { "Hill, Waylon" }
    let(:date) { "2022-04-17".to_date }

    context "when the speaker spoke previously" do
      it { expect(result).to eq(talks(:talk_2)) }
    end

    context "when the speaker spoke after but not previously" do
      let(:date) { "2022-03-03".to_date }
      it { expect(result).to be_nil }
    end

    context "when the speaker never spoke" do
      let(:name) { "Not a real speaker" }
      it { expect(result).to be_nil }
    end

    context "when name is blank" do
      let(:name) { "" }
      it { expect(result).to be_nil }
    end

    context "when name is nil" do
      let(:name) { nil }
      it { expect(result).to be_nil }
    end

    context "when date is nil" do
      let(:date) { nil }
      it { expect(result).to be_nil }
    end
  end
end
